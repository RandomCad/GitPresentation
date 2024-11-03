% Git
% Mathieu de Montmollin, Bernhard Lindner
% 09.10.2024
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

Git ist intern nicht wie übliche VCS aufgebaut. Intern ist Git eine Dateisystem mit einer VCS schnitstelle.  
Heutzuteage helfen viele kleinere und größer Programme Git als VCS zu verwendet.  

* Git ist kein Monolitisches Projekt sonderen besteht aus vielen einzelnen Programmen

::: notes
* Git ist fon der Implementeriung kein VCS sondern ein Dateisystem -> über dieses kann VSC gemacht werden
* Git ist intern keine datenbank sondern ähnelt viel mehr einem Git-Dateisystems
* nicht Dateisystem im sinne der Speicherverwaltung
* Git ist kein Monolitisches Projekt -> besteht aus vielen einzelteilen, welche zusammen arbeiten und Verwendet werden können
* Besitzt zum teile Zwei unteschiedliche Bestandteile, welche sehr ähnlich sind/ähliche aufgaben erfüllen
:::
::: notes
* Nachfolgend werden hauptsechlich Porcelain befehle erleutert -> komplexere befehle
* Es gibt auch die Plumbing befehle -> komplizierte internals
:::

# Technische Grundlagen - Datenfluss in Git

:::::::::::::: {.columns}  
::: {.column width="50%"}
Es gibt drei Datenebnen:

* Der git server
* Das locale Git-Repo
* Der momentan ausgecheckte Stand auch bezeichnet als Workingtree

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
    * Blob -> Ist der rohe inhalt einer in git abgelegten Datei. Wird ausschließlich über eine SHA1-Hash identifiziert. -> Git ist der Inhalt und das Format follkommen egal
    * Tree -> Entsprichd einen Ordner. Ein Tree beinhaltet referenzen auf andere Trees oder Blobs -> mit diesem objekt wäre theoretisch eine Versionsverwaltung bereits möglich -> erzuegung eines neuen Trees für jeden commit
    * commit object -> Dient dazu zu speichern, wer, wann, warum eine veränderung gespeichert hat -> Referenziert dabei einen Bestimmten Tree und potenzielle Parent Commits -> können mehrere Sein -> merging
    * Tag -> ähnelt einem Commit sehr stark -> referenziert irgende ein anderes objekt dauerhaft mit angabe wer, wann, weiso
    * Packs -> sind komprimierte versionen aller anderer Viles -> Mehrere Files werden zusammen betrachtet. Alle files, welche ähnliche größe und inhalt haben werden mithilfe von Delta-Kompression komprimiert -> ob diese dabei tatsechlich von einander abstammen ist git dabei egal -> git gc
    * Physisch werden die unterschiedlichen Datentypen sehr ähnlich gespeichert. Auf dieses wird hier nicht eingegangen
Quelle: https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain + 4 oder so Kapitel
:::

# Technische Grundlagen - Referenzen

* Referenzen sind benenungen auf bestimmte Datein des Git-Dateisystems
* Üblicherweise handelt es sich um Commit objeckte
* Branches entstehen über die erzeugung einer Neuen Referenzen auf einen Commit
* Head verweist üblicherweise auf eine andere Refernz

::: notes
Referenzen verweisen auf bestimmte Objecte im Dateisystem -> Typischerweise Commits
Über diese ist ein schnelleres erreichen/bearbeiten mit diesen möglich
Über diese werden alle Blätter im Commit baum typischerweise beibehalten
Grundsetzlich gibt es remote und local Refernces
Remotes verweise auf die ständen im Remote (Server) werden thypischerweise kaum/wenig verwendet.
Locals sind die thypischerweise verwendeten Referenzen
:::


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

--graph option

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

--allow-unrelated-history

# branching - git-rebase
# branching - git-cherry-pick

# submodules

::: notes
einfügen eines anderen Git repos im eigenen repository
* verwendung von externen librarys
* weden dann seperat behandelt
* mehr beim checkout/clone

* submodules müssen händisch geupdated werden. Sowhol um grundzätzlich neue versionen zu erhalten als auch wenn jemand anderes die Version geändert hat.
:::

# remotes - git-clone
::: notes
* options about local git repositorys
* options for big repositorys
    * spars-checkout -> only checkout parts of the directory
    * depth -> only go so fare back
* template repo
* submodules 
:::

# remotes - git-fetch

::: notes
soweit ich verstehe beschaft git fetch alle daten vom remote und updatet das Git-VS führt aber keine änderung am Workingtree durch.
-> es ist alles da um Updates am Wokring tree durchzuführen. diese finden nur nicht stat.
:::
# remotes - git-pull

Führt intern folgende befehle aus:

1. git-fetch
2. git-rebase oder git-merge
    * abhängig von der Konfiguration  

::: notes
fetched die remotes und versucht dessen änderung umzusetzen. 
-> updated den wokringtree  

:::
# remotes - git-push

::: notes
* versucht eine update der refernzen des Servers zusammen mit den benötigten Objekten
* Quasie ein fetch für den server vom Client aus
* Fast forwarding
    * ein Push gelingt immer, wenn keine Daten ferlohren gehen. Ansonsten wird eine Warning generiert.
    * option --forc kann zum datenverändert verwendet werden -> gezieltes löschen eines Kommits, ...
    * force-with-leas  

:::
# remotes - git-remote

::: notes
* bereitstellung von Optionen zum einstellen von Servern
* Optionen wie(nur teil):
    * add
    * remove
    * update
    * prune (löschen von unverwendeten referenzen)
:::

# big repo
Mit git können auch sehr große Projekte bearbeitet werden. 
So wird heutzutage der Windows Kernal mit Git entwickelt. 
Aus diesem grund hat Microsoft einiges in die Optimierung von riesiegen Repositories in Git infestiert. 
Erwähnenswert sind dabei die folgenden Befehle:
* scalar -> Top level befehl hinter welchem sich eine reie von Unterbefehlen befindet
* git-maintenanc -> führt säuberungs und prefetchingaufgaben periodisch durch
::: notes
scalar
maintenance
:::

