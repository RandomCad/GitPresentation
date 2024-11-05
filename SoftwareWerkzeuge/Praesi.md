% Git
% Mathieu de Montmollin, Bernhard Lindner
% 09.10.2024
::: notes
Begrüßung
:::

# Reinfolge

1. Geschichte
2. Technische Grundlagen
3. Vorbereitung
4. Lineares VC
5. Branching
6. Remotes

::: notes
erklärung was wir wann machen wollen
:::

# Geschichte

* Entwicklung des Linux-Kernels seit 2002 mit BitKeeper
* 2005 sucht Linus Torwald eine neue Vesions Verwaltungs Software
* Monoton und andere damalige Optionen werden von Linus Torwald nicht als guter Ersatz angesehen
* Ab 3. April 2005 entwickelt Linus Torwald Git als Ersatz

::: notes
* Geschichte von Git begann am 23. Februar 2005, als dem Autor von BitKeeper, der Verwendeten VSC bekannt wurde, dass seine Software reverse-engineert wird
* öffenlich wurde die kommende Veränderung am 6. April 2005 mit Mail von Linus im Kernelforum, in welcher er angibt, nach einer Alternative zu suchen (Check)
* bereits drei Tage vorher begann Linus mit der Entwicklung von Git (https://marc.info/?l=git&m=117254154130732)
* Am 7 April wurde der erste Commit mit git durchgeführt
* Am 16 April wurde der erste Linux Kernel Commit mitels git durchgeführt
* Wenige Tage später der erste merge (https://marc.info/?l=git&m=117254154130732)
:::

# Geschichte

* Im Juni 2005 wird der Linux-Kernal 2.6.12 über git ausgeliefert
* Am 21.12.2005 wird die Version 1.0 von git veröffentlicht
* Bis heute wird weiter an git entwickelt
* Aktuelle version ist 2.47

::: notes
* Git ist dabei bei der Funktionsweise an BitKeeper und Monoton angelehnt
* erster Release war am 21 December 2005
* bennenung: Git als Kunstwort von Linus entwickelt, bedeutet soviel wie "unangenehme Person"
:::

# Technische Grundlagen

Git ist intern nicht wie ein übliches VCS aufgebaut, sondern wie ein Dateisystem mit einer VCS Schnitstelle.
Heutzuteage helfen viele kleinere und größer Programme Git als VCS zu verwendet.  

* Git ist kein monolitisches Projekt, sonderen besteht aus vielen einzelnen Programmen
* Git ist ein dezentrales VCS (DVCS)

::: notes
* Git ist von der Implementeriung kein VCS sondern ein Dateisystem -> über dieses kann VSC gemacht werden
* Git ist intern keine datenbank sondern ähnelt viel mehr einem Git-Dateisystem
* nicht Dateisystem im sinne der Speicherverwaltung
* Git ist kein Monolitisches Projekt -> besteht aus vielen einzelteilen, welche zusammen arbeiten und Verwendet werden können
* Besitzt zum teile Zwei unteschiedliche Bestandteile, welche sehr ähnlich sind/ähliche aufgaben erfüllen
* dezentrales VCS -> nutzer besitzt große teile als lokale kopie -> braucht nicht immer server -> nur wenn er änderungen veröffentlichen will
:::
::: notes
* Nachfolgend werden hauptsechlich Porcelain befehle erleutert -> komplexere befehle
* Es gibt auch die Plumbing befehle -> komplizierte internals
:::

# Technische Grundlagen - Datenfluss in Git

:::::::::::::: {.columns}  
::: {.column width="50%"}
Es gibt drei Datenebnen:

* Der git Server
* Das locale Git-Repository
* Der momentan ausgecheckte Stand, auch bezeichnet als Workingtree

:::
::: {.column width="50%"}
![By Daniel Kinzler - Own work, CC BY 3.0, https://commons.wikimedia.org/w/index.php?curid=25223536](GitDataflow.png)
:::
::::::::::::::

::: notes
erklärung, wei der Datenfluss bei Git ist:
* Drei orte, an welchen daten liegen
    * Remote(server (potenziel gestuft))
    * Git Filesystem (internals) -> gesammte historie
    * Workingtree -> Präsentation des Momentan standes im Dateisystem -> kann/wird bearbeitet
* Wie bewegen sich daten von einem Ort in den anderen:
    * Remote -> generelle datenbank
    * generale datenbank -> Branches
    * Branch -> Workingtree : git checkout
    * Workingtree -> staging : git add
    * Staging -> Branch : git commit
* Auf das staging gehen wir beim Commit ein?
:::


# Technische Grundlagen - Git Dateitypen

* Blob
* Tree
* commit
* Tag
* Pack

::: notes
* Dateitypen:
    * Blob -> Ist der rohe inhalt einer in git abgelegten Datei. Wird ausschließlich über eine SHA1-Hash identifiziert. -> Git ist der Inhalt und das Format vollkommen egal
    * Tree -> Entsprichd einen Ordner. Ein Tree beinhaltet referenzen auf andere Trees oder Blobs -> mit diesem objekt wäre theoretisch eine Versionsverwaltung bereits möglich -> erzuegung eines neuen Trees für jeden commit
    * commit object -> Dient dazu zu speichern, wer, wann, warum eine veränderung gespeichert hat -> Referenziert dabei einen bestimmten Tree und potenzielle Parent Commits -> können mehrere Sein -> merging
    * Tag -> ähnelt einem Commit sehr stark -> referenziert irgend ein anderes objekt dauerhaft mit angabe wer, wann, weiso
    * Packs -> sind komprimierte versionen aller anderer Files -> Mehrere Files werden zusammen betrachtet. Alle files, welche ähnliche größe und inhalt haben werden mithilfe von Delta-Kompression komprimiert -> ob diese dabei tatsächlich von einander abstammen ist git dabei egal -> git gc
    * Physisch werden die unterschiedlichen Datentypen sehr ähnlich gespeichert. Auf dieses wird hier nicht eingegangen

* Beispiel:
    * main.c, common.h als Blob -> verschiedene Stände -> verschiedene Blobs
    * src/ als Tree -> Tree1 enthält Blob(main.c, v1) + Blob(common.h, v1), Tree2 enthält Blob(main.c, v2) + Blob(common.h, v1)

Quelle: https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain + 4 oder so Kapitel
:::

# Technische Grundlagen - Referenzen

* Referenzen sind benannte Verweise auf bestimmte Objekte des Git-Dateisystems
* Üblicherweise handelt es sich um Commits
* Branches entstehen über die erzeugung einer Neuen Referenzen auf einen Commit
* HEAD verweist üblicherweise auf eine andere Refernz

::: notes
* Referenzen verweisen auf bestimmte Objekte im Dateisystem -> Typischerweise Commits
* Über diese ist ein schnelleres erreichen/bearbeiten mit diesen möglich
* Über diese werden alle Blätter im Commit baum typischerweise beibehalten
* Grundsätzlich gibt es remote und local References
* Remotes verweise auf die Stände im Remote (Server), werden typischerweise kaum/wenig verwendet.
* Locals sind die typischerweise verwendeten Referenzen
:::

# Vorbereitung - git-config
`git config set --global user.name <name>`

`git config set --global user.email <email>`

Unter Windows: `git config set --global core.autocrlf true`

<!-- essentials -->
# lineares VC - git-init
# lineares VC - git-status

# lineares VC - git-add

`git add <path...>` - fügt Dateien dem Index hinzu

Optionen:

- `-A` `--all`: Betrachte alle Dateien
- `-f` `--force`: ignoriere .gitignore
- `-p` `--patch`: Interaktive Auswahl der einzelnen Änderungen innerhalb einer Datei

# lineares VC - git-rm

`git rm <path...>` - löscht Dateien aus Index und Working Tree

Optionen:

- `-f` `--force`: ermöglicht löschen von Dateien, zu denen der Index ereits Änderungen beinhaltet
- `--cached`: ändert ausschließlich den Index

# lineares VC - git-commit
`git commit` - erzeugt einen neuen Commit

Es existieren verschieden Möglichkeiten, welche Dateien im Commit gespeichert werden:

- direkte angabe als Argument, z.B. `git commit Praesi.md`
- `-a`: für alle Änderungen
- `--interactive` oder `--patch`, um interaktiv zu entscheiden
- ohne Angaben wird der Index committed

::: notes
* `-a` -> alle Änderungen an **bereits bekannten** Dateien aufzunehmen
* Ansonsten wird der Stand des Indexes, der über `git add` und `git rm` bearbeitet wurde, verwendet
:::

# lineares VC - git-commit
Optionen:

- `-m <msg>` `--message=<msg>`: setzt die Commit-Nachricht
- `--amend`: ändere den letzten Commit, anstatt einen neuen zu erzeugen
- `-S` `--gpg-sign`: erzeugt einen signierten Commit  


# lineares VC - git-show

`git show <object>` - zeigt Informationen über ein Objekt (meist ein Commit) an

Angabe des Objektes:

- Name es Objekts
    - Commits: Hash bzw. eindeutiger Präfix
    - Branches, Tags
    - HEAD
    
# lineares VC - git-show
Angabe des Objektes:

* relativ zu anderen Objekten:
    * `<obj>^` ist der unmittelbare Vorgänger
    * `<obj>~<n>` ist der nte Vorgänger
    * `HEAD^^^` = `HEAD~3`
* `:/<regex>`: sucht nach einem Commit mit der Nachricht `<regex>`

# lineares VC - git-show
Angabe des Objektes:

* `<ref>@{<time>}`: gibt den Stand einer Referenz (Branch, HEAD) zu einem Zeitpunkt an, z.B. `main@{yesterday}` oder `HEAD@{5 minutes ago}`

Optionen für `git show`:

- `-s` `--no-patch`: zeigt keine Änderungen an

# lineares VC - .gitignore
Eine .gitignore Datei gibt Pfade an, die von git ignoriert werden sollen. Jedes Verzeichnis kann eine eigene .gitignore haben.
```shell
# ignore object files
*.o
# ignore everything in folder static,
static/*
# but not this file
!static/favicon.ico
```

# lineares VC - git-diff

`git diff [-- <path...>]` - zeigt die Unterschiede zwischen verscshiedenen Versionen von Dateien an.

* ohne optionen: Index <-> Working Tree
* `--cached [<commit>]`: Index <-> Commit (HEAD, falls kein Commit angegeben)
* `<commit>`: Commit <-> Working Tree
* `<commit> <commit>`: Commit 1 <-> Commit 2

Optionen:

* `--word-diff`: zeigt Änderungen innerhalb einer Zeile an

::: notes
* `--` bedeuted alles folgende sind pfade
* `<path>` kann zum filtern angegeben werden
* --word-diff sehr angenehm wenn einzelne wörter geändert werden, für gesamte zeilen aber eher ungeeignet
:::
# lineares VC - git-log
`git log` - zeigt die Commit-Historie an

Je nach Argumenten können verschiedene Ausgaben erreicht werden:

* `git log`: gesamte lineare Historie
* `git log <commit1>..<commit2>`: Spanne an Commits
* `git log -L <hunk>`: Historie eines Bereichs
    * Bereich: `<start>,<end>:<file>` oder `:<funcname>:<file>`
* `git log [--follow] <file>`: Historie einer Datei

::: notes
* ohne optionen: zeigt, beginnend bei HEAD, alle direkten Vorgänger an, bis hin zum initialen Commit
* `<commit1>..<commit2>` zeigt alle Commits NACH `<commit1>` bis `<commit2>` an
* Mit `--follow` werden Umbenennungen der Datei mit beachtet
:::

# lineares VC - git-log
Optionen:

* `--graph`: zeichnet einen Graphen links von der Ausgabe
* `-n <number>`: limitiert die Ausgabe auf `<number>` Commits
<!-- Nützlich -->

# lineares VC - git-tag
`git tag` - Erstellt, löscht und listet Tags.

* `git tag <name> [<commit>]`: erstellt einen neuen commit
* `git tag -l [<pattern>]`: listet commits, die pattern entsprechen
* `git tag -d <name>`: löscht einen tag

::: notes
* unterscheidung zwischen 'annotated' und 'lightweight' tags: annotated haben nachricht und können signiert (und verifiziert) werden -> releases, lightweight sind nur benannte referenz auf commit -> interne nutzung
* annotated tags über -a, message -m, signed -s
:::
# lineares VC - git-blame
`git blame <file>` - zeigt für jede Zeile an, wer diese zuletzt bearbeitet hat

Optionen:

* `-L <hunk>`: begrenzt die Ausgabe auf einen Bereich
* `-w`: ignoriert Whitespace-Änderungen
* `-C`: ignoriert Commits, in denen die Zeile nur verschoben und nicht geändert wurde

::: notes
* `-L`: analog zu `git log -L`
* `-C`: bis zu dreimal angeben um mehr Commits zu durchsuchen
:::

# lineares VC - git-config
`git config` - Konfiguration von git

Verschiedene Unterbefehle:

* `git config get <key>`: liest einen Wert
* `git config list`: zeigt alle Werte
* `git config set <key> <value>`: setzt einen Wert

Optionen:

* `--global`: betrachtet globale Einstellungen

::: notes
* key-value-pairs, kein schutz vor rechtschreibfehlern
* global -> für den nutzer, default ist --local -> repository spezifisch
:::
<!-- undo -->
# lineares VC - Änderungen Rückgängig machen
![By Scott Chacon - Own work, https://x.com/chacon/status/1699346208618127745](venn.jpg)

# lineares VC - git-reset
`git reset [<commit>] <path...>` - setzt den Stand der angegeben Pfade im Index auf den Stand im angegebenen Commit zurück

Optionen:

* `-p` `--patch`: um interaktiv Änderungen auszuwählen

::: notes
* undo git add: set files in index to state of earlier commits (default HEAD)
:::

# lineares VC - git-reset
`git reset [<mode>] [<commit>]` - Ändert HEAD auf `<commit>`

Modi:

* `--soft`: lässt Index und Working Tree unverändert
* `--mixed`: (default) ändert Index, aber nicht Working Tree
* `--hard`: ändert Index und Working Tree
* `--keep`: wie `--hard`, behält lokale Änderungen bei

::: notes
* --keep: Working Tree wird geändert für alle Dateien mit Differenz HEAD <> commit, wenn lokale Änderungen --> Abbruch
:::

# lineares VC - git-restore
`git restore <path...>` - Setzt Dateien im Working Tree auf eine frühere Version zurück

Quelle:

* Option `--source=<commit>`
* HEAD, falls `--staged` angegeben ist
* sonst Index

# lineares VC - git-restore
Optionen:

* `-S` `--staged`: Ändert auch den Index
* `-W` `--worktree`: Ändert den Working Tree
* `-p` `--patch`: interaktive Auswahl der Änderungen
* `--source=<commit>`: andere Quelle

::: notes
* -S -W kann genutzt werden, um Index und Working Tree rückgängig zu machen
:::

# lineares VC - git-revert
`git revert <commit...>` - macht Commits rückgängig

Optionen:

* `-n` `--no-commit`: ändert Index und Working Tree, erzeugt jedoch keinen Commit
* während der Ausführung: `--continue` | `--skip` | `--quit` | `--abort`

::: notes
* erfordert cleanen Working Tree (keine Änderungen zu HEAD)
* erzeugt neue Commits, die die Änderungen der angegebene Rückgängig machen
* --continue macht mit nächstem commit weiter
* --skip überspringt commit
* --quit gegenteil von --continue
* --abort abbruch, macht alle änderungen dieses befehls rückgängig 
:::

<!-- stash -->
# lineares VC - git-stash

# branching - git-branch
# branching - git-checkout
# branching - git-switch
`git switch <branch>` - wechsel den Working-Tree zu `<branch>`

Optionen:

* `-c` `--creat`: erstelle eine neue branch mit namen `<branch>` von dieser stelle aus.
* `-d` `--detach`: wechsle zum commit `<branch>` und gehe in den DETACHEDHEAD-zustand.
* `-m` `--merge`: führe einen Merge mit den actuellen Working-Tree daten durch um diese in die neue Branch zu übertragen

::: notes
macht das was checkout machen sollte. 
:::

# branching - git-merge
`git merge <branch>` - erfasse die änderungen bis zu branch und führe diese Änderungen in einem einzelnem Commit aus.

Es ist empfehenswert keine änderungen im Working-Tree zu haben.

::: notes
* keine änderungen, da diese bei einem Mergkonflick und abort nicht korrekt zurückgespielt werden könnten
:::

# branching - git-merge
Optionen:

* `--no-commit`: stope for dem Commit. Dadurch können for dem kommit noch änderungen forgenommen werden
* `-e`: öffne einen Edito um die Merge message bearbeiten zu können
* `--squash`: der erzeugte end commit muss händisch ausgeführt werden und refernziert den letzten commit der branch nicht. 

# branching - git-merge
Optionen:

* `--allow-unrelated-history`: standartmäsig wird es nicht erlaubt zwei branches zu merge, die keinen gemeinsammen forfahren haben. Dies überschreibt dieses Verhalten.
* während der Ausführung: `--continue` | `--skip` | `--quit` | `--abort`

# branching - git-rebase
`git rebase <upstream>` - verschiebe die commits der Branch and den Kopf von `<upstream>`

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

* `--onto <newbase> <upstream> <branch>`: Verschiebt die Commits zwischen `<upstream>` und `<branch>` auf newbase.
* `--keep-base`: setzt die kommits von der Branch nicht an das Ende von Upstream sondern behält den basiskommit bei.

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

* `--autosquash`: füge alle commits, welche als "squash!", "fixup!" oder "amand!" declariert sind zu den entsprechenden Commits hinzu. 
* `--autostash`: führt for dem rebas ein stash aus und popt diesen nach dem erfolgreichen rebase.


::: notes
autosquash - fast commits zusammen, welche spezielle commit werte haben.
:::

Übung: commit --fixup && rebase --autosquash

# branching - git-cherry-pick
`git cherry-pick <commit...>` - versucht die Änderungen der Commits auf den eigenen HEAD anzuwenden. Es wird für jeden Commit dafür ein neuer Commit erzeugt.  

Sollte einer der Commits nicht anwendbar sein, bleibt der eigenen HEAD und Working-Tree beim forherigen erfolgreichen Commit stehen. 
Daraufhin werden die nicht automatisch mergbare angaben im Working-Tree mit der standart Mergangaben ausgegeben.

::: notes
* erfordert cleanen Working Tree (keine Änderungen zu HEAD)
* erzeugt neue Commits über HEAD, welche die änderungen der angegeben Commits beinhaltet
:::
# branching - git-cherry-pick

Optionen:

* `-e`: ermöglicht das editieren der Commitmassage jedes Commits for dem einfügen diese
* `-x`: fügt in der Commitmassag eine Zeile hinzu, in welcher angegeben wird, von wo der Commit per cheripick eingefügt wurd.

::: notes
* Optionen erläutern
:::

# branching - git-cherry-pick

Optionen:

* `--empty=(drop|keep|stop): wie soll mit commits umgegeange werden, die in meinem verlauf berits existieren/keine änderung herbei führen.

* während der Ausführung: `--continue` | `--skip` | `--quit` | `--abort`

::: notes
* Optionen erläutern
* nach einem mergconflick können verwendet werden.
* --continue macht mit nächstem commit weiter
* --skip überspringt commit
* --quit gegenteil von --continue
* --abort abbruch, macht alle änderungen dieses befehls rückgängig 
:::

# Submodule
Es ist nicht ungewöhnlich, dass man ein anderes Repository in sein eigenes Repository einbinden möchte. 
Dafür gibt es git-submodules.  

Mit diesen kann man den Inhalt eines anderen Repositories in das eigene einbinden. 
Dabei wird das fremde Git-Repository nicht komplett in das eigene Repository eingefügt, sondern nur angegeben, welcher Commit aus diesem geladen werden soll.  
Dadurch ändert sich die Funktionsweise von git-pull und git-fetch. 

::: notes
Einfügen eines anderen Git Repositories in das eigene Repository
* Verwendung von externen Bibliotheken
* werden separat behandelt
* mehr beim Checkout/Klonen zu machen

* Submodule müssen manuell aktualisiert werden. Sowohl um grundsätzlich neue Versionen zu erhalten, als auch wenn jemand anderes die Version geändert hat.
* Wie Änderungen gespeichert werden, ist nicht Gegenstand dieser Präsentation.
:::

# remotes - git-clone
`git clone <repository-url>` - Lädt die aktuelle Version vom Server in ein neues Verzeichnis.

Optionen:

- `-l`, `-s` Optimierungsoption für bereits lokal existierende Repositories. Es wird versucht, so wenig Dateien wie möglich zu duplizieren.
- `--spars`: lade nur die Dateien im ersten Unterverzeichnis.
- `--depth`: lade nur X Commits aus allen Zweigen herunter.

::: notes
* Optionen für lokale Git Repositories
* Optionen für große Repositories
    * spars-checkout -> nur Teile des Repositorys auschecken, also nur X tief. Mit git-spars-checkout kann erweitert werden
    * Tiefe -> nur so weit zurück 
:::

# remotes - git-fetch

`git fetch` - Lädt die Git-Objekte vom Server, ändert aber nicht den Working Tree oder die eigenen Referenzen.

Hat Optionen um mit mehreren entfernten Servern und unvollständigen Repositories zu arbeiten.

::: notes
So wie ich es verstehe, holt git fetch alle Daten vom Remote und aktualisiert das Git-VS, macht aber keine Änderungen am Workingtree.
-> Es ist alles da, um Updates am working-tree durchzuführen, aber es passiert nichts.
:::

# remotes - git-pull

Führt die folgenden Befehle intern aus:

1. `git-fetch`
2. `git-rebase` oder `git-merge`
    * abhängig von der Konfiguration  

::: notes
Holt die Remotes und versucht deren Änderungen zu übernehmen. 
-> aktualisiert den wokringtree  
:::

# remotes - git-push

`git push` - Aktualisiert das Git-Repository des Servers mit den aktuellen Daten, wenn möglich.

Optionen:

* `--all` - Aktualisiert alle Refernenzen, nicht nur die im aktuellen Verzeichnisbaum.
* `--foce` - Aktualisiert den Server, auch wenn dabei Daten verloren gehen.
* `--force-with-lease` - Aktualisiert den Server auch wenn Daten verloren gehen, aber nur wenn die Serverreferenz mit der Locale übereinstimmt.

::: notes
* Versucht die Referenzen des Servers zusammen mit den benötigten Objekten zu aktualisieren.
* Quasi ein Fetch für den Server vom Client.
* Fast Forwarding
    * Ein Push ist immer erfolgreich, wenn keine Daten verloren gehen. Andernfalls wird eine Warnung erzeugt.
    * Option --forc kann verwendet werden, um Daten zu verändern -> gezieltes Löschen eines Commits, ...
    * force-with-leas  
* --set-upstream
:::

# remotes - git-push
Optionen:

* `--set-upstream` - Fügt einen Verweis im Server hinzu. Wird immer beim ersten Push eines neuen Zweigs benötigt.

::: notes
* versucht eine update der refernzen des Servers zusammen mit den benötigten Objekten
* Quasie ein fetch für den server vom Client aus
* Fast forwarding
    * ein Push gelingt immer, wenn keine Daten ferlohren gehen. Ansonsten wird eine Warning generiert.
    * option --forc kann zum datenverändert verwendet werden -> gezieltes löschen eines Kommits, ...
    * force-with-leas  
* --set-upstream

:::

# remotes - git-remote
Verwaltet Git-Server. Hat mehrere Unterbefehle:

* `git remote add` - fügt einen neuen Server hinzu
* `git remote remove` - Entfernt einen Server
* `git remote update` - Führt ein fetch für alle remotes aus.
* `git remote prune` - Löscht lokale Referenzen, die nicht auf dem Server existieren und nicht benutzt werden.
* ...

::: notes
* Optionen für das Einrichten von Servern.
* Optionen wie
    * hinzufügen
    * entfernen
    * aktualisieren
    * prune (unbenutzte Referenzen löschen)
:::

# großes Repository

Mit Git können auch sehr große Projekte bearbeitet werden. 
Zum Beispiel wird heute der Windows Kernel mit Git entwickelt. 
Aus diesem Grund hat Microsoft viel in die Optimierung von großen Repositories in Git investiert. 
Erwähnenswert sind folgende Befehle:

* `scalar` -> Befehl der obersten Ebene, hinter dem eine Reihe von Unterbefehlen stehen
* `git-maintenanc` -> Führt periodisch Aufräum- und Prefetch-Aufgaben aus -> beschleunigt die Arbeit mit Git

::: notes
scalar
maintenance
:::

# Übung

