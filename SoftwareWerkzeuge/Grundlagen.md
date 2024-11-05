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
