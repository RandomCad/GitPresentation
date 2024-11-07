# branching

Bei einem Mergekonflikt werden die Unterschiede im Working-Tree wie folgt angezeigt:

`<umgebung>`  
`<<< deins`  
`<die lokalen Änderungen>`  
`===`  
`<die Änderungen der anderen Branch>`  
`>>> ende`  
`<umgebung>`    

::: notes
was ist merging und wie funktioniert das!
* Div von beiden seiten und das dann versuchen automatisch zusammen zu fügen
:::

# branching

Möglichkeiten einen Branch zu erzeugen:

* `git branch <name>`
* `git checkout -b <name>`
* `git switch -c <name>` 
* `git stash branch`

# branching - git-branch
`git branch` - verwaltet Branches

* `git branch -l` - listet Branches
* `git branch <branch> [<commit>]` - erstellt neuen Branch
* `git branch -m <old> <new>` - bennent einen Branch um
* `git branch -d <branch>` - löscht einen Branch

::: notes
* branches sind benannte referenzen auf commits
* HEAD zeigt (meist) auf einen branch, dieser ändert sich automatisch bei git commit
* neu erstellter Branch: HEAD ändert sich nicht -> man bleibt auf altem Branch
:::

# branching - git-branch

Optionen:

* `--sort=-committerdate`: zeigt aktuelle Branches zuerst
* `-M`: `-m` mit force
* `-c` `-C`: wie `-m` `-M`, jedoch wird kopiert

::: notes
* branches sind benannte referenzen auf commits
* HEAD zeigt (meist) auf einen branch, dieser ändert sich automatisch bei git commit
* neu erstellter Branch: HEAD ändert sich nicht -> man bleibt auf altem Branch
:::

# branching - git-checkout
`git checkout` - wechselt Branches

* `git checkout <branch>` - wechselt zu Branch
* `git checkout --detach <commit>` - wechselt als detached HEAD zu commit
* `git chekcout -b <branch>` - erstellt neuen Branch und wechselt dorthin
* `git checkout [<commit>] <path...>` - überschreibt lokale Dateien

::: notes
* --detach: detached HEAD -> HEAD zeigt nicht auf branch, sondern direkt auf commit -> keine neuen commits möglich -> kann verwendet werden, um stand zu altem zeitpunkt anzuschauen -> muss mit git checkout &lt;branch&gt; beendet werden, um wieder arbeiten zu können
* mit &lt;path...&gt; eher wie git restore: ohne angbe von &lt;commit&gt;: Index -> Worktree, mit Angabe von commit: commit -> Index + Worktree
:::

# branching - git-checkout
Optionen:

* `-f` `--force`: überschreibt lokale Änderungen
* `-m` `--merge`: ermöglicht three-way-merge

# branching - git-switch
`git switch <branch>` - wechselt den Working-Tree zu `<branch>`

Optionen:

* `-c` `--create`: erstelle einen neuen Branch mit namen `<branch>` von dieser Stelle aus.
* `-d` `--detach`: wechsle zum commit `<branch>` und gehe in den detached Head Zustand
* `-m` `--merge`: führe einen Merge mit dem aktuellen Working-Tree durch, um diese in den neuen Branch zu übertragen

::: notes
macht das was checkout machen sollte. 
:::

# branching - git-merge
`git merge <branch>` - erfasse die Änderungen bis zu Branch und führe diese Änderungen in einem einzelnem Commit aus.

Es ist empfehlenswert keine änderungen im Working-Tree zu haben.

::: notes
* keine änderungen, da diese bei einem Mergekonflikt und abort nicht korrekt zurückgespielt werden könnten
:::

# branching - git-merge
Optionen:

* `--no-commit`: stoppe vor dem Commit, um Änderungen vorzunehmen
* `-e`: öffne einen Editor um die Merge message bearbeiten zu können
* `--squash`: der erzeugte end Commit muss händisch ausgeführt werden und referenziert den letzten Commit des Branches nicht. 

# branching - git-merge
Optionen:

* `--allow-unrelated-history`: erlaubt das mergen von Branches, die keinen gemeinsammen Vorfahren haben
* während der Ausführung: `--continue` | `--skip` | `--quit` | `--abort`

# branching - git-rebase
`git rebase <upstream>` - verschiebe die Commits des aktuellen Branchs and den Kopf von `<upstream>`

Erzeuge dafür neue Commits ab dem HEAD von `<upstream>`

::: notes
erkläre mit diesen abbildern 
          A---B---C topic
         /
D---E---F---G master
              A'---B'---C' topic
             /
D---E---F---G master
:::

# branching - git-rebase
Optionen:

* `--onto <newbase> <upstream> <branch>`: Verschiebt die Commits zwischen `<upstream>` und `<branch>` auf `<newbase>`.
* `--keep-base`: setzt die Commits von der Branch nicht an das Ende von Upstream sondern behält den Basiscommit bei.

::: notes
    o---o---o---o---o  master
        |            \
        |             o'--o'--o'  topic
         \
          o---o---o---o---o  next

git rebase --onto master next topic
:::

# branching - git-rebase
Optionen:

* `--autosquash`: füge alle commits, welche als "squash!", "fixup!" oder "amend!" deklariert sind, zu den entsprechenden Commits hinzu 
* `--autostash`: führt vor dem rebase ein stash aus und popt diesen nach dem erfolgreichen rebase.


::: notes
autosquash - fasst commits zusammen, welche spezielle commit nachrichten haben -> erstellt mit commit --fixup
:::

Übung: commit --fixup && rebase --autosquash

# branching - git-cherry-pick
`git cherry-pick <commit...>` - versucht die Änderungen der Commits auf den eigenen HEAD anzuwenden. Es wird für jeden Commit dafür ein neuer Commit erzeugt.  

Sollte einer der Commits nicht anwendbar sein, bleibt der eigenen HEAD und Working-Tree beim zuletzt erfolgreichen Commit stehen. 
Daraufhin werden die nicht automatisch mergbaren angaben im Working-Tree mit der standard Mergangaben ausgegeben.

::: notes
* erfordert cleanen Working Tree (keine Änderungen zu HEAD)
* erzeugt neue Commits über HEAD, welche die änderungen der angegeben Commits beinhaltet
:::
# branching - git-cherry-pick

Optionen:

* `-e`: ermöglicht das editieren der Commitmassage jedes Commits vor dem einfügen desselben
* `-x`: fügt in der Commitmessage eine Zeile hinzu, in welcher angegeben wird, von wo der Commit per cherrypick eingefügt wurd.

::: notes
* Optionen erläutern
:::

# branching - git-cherry-pick

Optionen:

* `--empty=(drop|keep|stop)`: wie soll mit commits umgegeange werden, die in meinem verlauf berits existieren/keine Änderung herbeiführen.

* während der Ausführung: `--continue` | `--skip` | `--quit` | `--abort`

::: notes
* Optionen erläutern
* nach einem mergekonflikt können verwendet werden:
    * --continue macht mit nächstem commit weiter
    * --skip überspringt commit
    * --quit gegenteil von --continue
    * --abort abbruch, macht alle änderungen dieses befehls rückgängig 
:::
