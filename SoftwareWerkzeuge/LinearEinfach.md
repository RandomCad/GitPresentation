# Vorbereitung - git-config
`git config set --global user.name <name>`

`git config set --global user.email <email>`

Unter Windows: `git config set --global core.autocrlf true`

<!-- essentials -->
# lineares VC - git-init
`git init` - initialisiert neues repository

Optionen:

* `-b <branch>` `--initial-branch=<branch>`: setzt namen des initialen branches
* `git -C <dir> init`: anderes working directory

::: notes
* aktuelles working directory als neues repository
* -C ist option von git selbst um cwd des subcommands zu ändern
:::

# lineares VC - git-status
`git status` - zeigt status des working trees
	
Optionen:

* `-s` `--short`: kurze Ausgabe
* `-b` `--branch`: zeigt aktuellen Branch an
* `--ignored`: zeigt ignorierte Pfade an

::: notes
* --long als default, überschreibt -s
* -b nur relevant bei -s
:::

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

* `-m <msg>` `--message=<msg>`: setzt die Commit-Nachricht
* `--amend`: ändere den letzten Commit, anstatt einen neuen zu erzeugen
* `-S` `--gpg-sign`: erzeugt einen signierten Commit  
* `--fixup=<commit>`: setzt Commit-Nachricht für `git rebase --autosquash`

::: notes
* --fixup: man sagt "korrigiere diesen commit", durch rebase --autosquash wird der entsprechende commit angepasst, nachfolgende bleiben gleich
:::

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

# lineares VC - git-diff
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

# lineares VC - git-log

* `git log [--follow] <file>`: Historie einer Datei
* `git log -S<string>`: Die Spitzhacke

::: notes
* ohne optionen: zeigt, beginnend bei HEAD, alle direkten Vorgänger an, bis hin zum initialen Commit
* `<commit1>..<commit2>` zeigt alle Commits NACH `<commit1>` bis `<commit2>` an
* Mit `--follow` werden Umbenennungen der Datei mit beachtet
* Spitzhacke: filtert nach commits in denen sich die Häufigkeit von &lt;string&gt; ändert -> nur verschiebungen werden ignoriert, riskiert aber nicht alles zu finden -> -G&lt;string&gt; nutzen -> -G ist immer regex
* --pickaxe-regex für regex search
:::

Optionen:

* `--graph`: zeichnet einen Graphen links von der Ausgabe
* `-n <number>`: limitiert die Ausgabe auf `<number>` Commits
* `--reverse`: umgekehrte Reihenfolge

