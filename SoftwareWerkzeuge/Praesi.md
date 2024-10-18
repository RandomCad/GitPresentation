% Titel
% Mathieu de Montmollin, Bernhard Lindner
% 09.10.2024

# Einführung

::: notes
Begrüsung
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
* Entwicklung des Linux-Kernals seit 2002 mit BitKeeper
* 2005 sucht Linus Torwald einen neue Vesions Verwaltungs Software
* Monoton und andere damaliege Optionen werden von Linus Torwald nicht als guter ersatzt angesehen
* Ab 3 April 2005 entwickelt Lius Torwald Git als erstatz
::: notes
* Geschichte von Git begann am 23 Feruar 2005 als dem autor von BitKeeper der Verwendeten VSC bekannt wurde, das seine software reversengeniert wird
* öffenlic wurde die kommende veränderung am 6 April 2005 mit Mail von Linus im Kernalforum in welcher er angibt nach einer Alternative zu suchen (Check)
* bereits drei tage forher begann Linus mit der entwicklung von Git (https://marc.info/?l=git&m=117254154130732)
* Am 7 April wurde der erste commit mit git durchgeführt
* Am 16 April wurde der erste Linux Kernal kommit mitels git durchgeführt
* Wenige Tage später der erste merge (https://marc.info/?l=git&m=117254154130732)
:::

# Geschichte
* Im Juni 2005 wird der Linux-Kernal 2.6.12 über git ausgeliefert
* Am 21.12.2005 wird die Version 1.0 von git veröffentlicht
* Bis heute wird weiter an git entwickelt
* Aktuelle version ist 2.47

::: notes
* Git ist dabei bei der Funktionsweise an BitKeeper und Monoton angelehnt
* erster releas war am 21 December 2005
* bennenung: Git als kunstwort von Linus entwickelt bedeutet soviel wie unangenehme Person
:::

# Technische Grundlagen
Git ist kein wirkliches VCS. Eigentlich ist Git eine Filesystem mit einer VCS schnitstelle.  
Heutzuteage helfen viele kleinere und größer Programme Git als VCS zu verwendet.  

* Git ist kein Monolitisches Projekt sonderen besteht aus vielen einzelnen Programmen

::: notes
* Git ist fon der Implementeriung kein VCS sondern ein Dateisystem -> über dieses kann VSC gemacht werden
* Git ist intern keine datenbank sondern ähnelt viel mehr einem Dateisystem
* Git ist kein Monolitisches Projekt -> besteht aus vielen einzelteilen, welche zusammen arbeiten und Verwendet werden können
* Besitzt zum teile Zwei unteschiedliche Bestandteile, welche sehr ähnlich sind/ähliche aufgaben erfüllen
:::

# Technische Grundlagen - Git Dateitypen

* Blob
* Tree
* commit
* Tag
* Pack

::: notes
* Dateitypen:
    * Blob -> Ist der rohe inhalt einer in git abgelegten Datei. Wird ausschließlich über eine SHA1-Hash identifiziert. -> Git ist der Inhalt und das Format follkommen egal
    * Tree -> Entsprichd einen Ordner. Ein Tree beinhaltet referenzen auf andere Trees oder Blobs -> mit diesem objekt wäre theoretisch eine Versionsverwaltung bereits möglich -> erzuegung eines neuen Trees für jeden commit
    * commit object -> Dient dazu zu speichern, wer, wann, warum eine veränderung gespeichert hat -> Referenziert dabei einen Bestimmten Tree und potenzielle Parent Commits -> können mehrere Sein -> merging
    * Tag -> ähnelt einem Commit sehr stark -> referenziert irgende ein anderes objekt dauerhaft mit angabe wer, wann, weiso
    * Packs -> sind komprimierte versionen aller anderer Viles -> Mehrere Files werden zusammen betrachtet. Alle files, welche ähnliche größe und inhalt haben werden mithilfe von diffs komprimiert -> ob diese dabei tatsechlich von einander abstammen ist git dabei egal -> git gc
    * Physisch werden die unterschiedlichen Datentypen sehr ähnlich gespeichert. Auf dieses wird hier nicht eingegangen
Quelle: https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain + 4 oder so Kapitel
:::

Do something with (this)[https://en.wikipedia.org/wiki/Git#/media/File:Git_operations.svg]

# Vorbereitung - git-config
# Vorbereitung - git-clone
<!-- essentials -->
# lineares VC - git-init
# lineares VC - git-status
# lineares VC - git-add und git-rm
# lineares VC - git-commit
# lineares VC - .gitignore
# lineares VC - git-diff
# lineares VC - git-log
<!-- Nützlich -->
# lineares VC - git-tag
# lineares VC - git-blame
# lineares VC - git-clean
# lineares VC - git-config
<!-- undo -->
# lineares VC - git-reset
# lineares VC - git-restor
# lineares VC - git-revert
<!-- stash -->
# lineares VC - git-stash

# branching - git-branch
# branching - git-checkout
# branching - git-switch
# branching - git-merge
# branching - git-rebase
# branching - git-cherry-pick

# remotes - git-clone
# remotes - git-fetch
# remotes - git-pull
# remotes - git-push
# remotes - git-remote
# remotes - unrelated history
