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
- `--sparse`: lade nur die Dateien im ersten Unterverzeichnis.
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
* `--force-with-lease` - Aktualisiert den Server auch wenn Daten verloren gehen, aber nur wenn die Serverreferenz mit der lokalen übereinstimmt.

::: notes
* Versucht die Referenzen des Servers zusammen mit den benötigten Objekten zu aktualisieren.
* Quasi ein Fetch für den Server vom Client.
* Fast Forwarding
    * Ein Push ist immer erfolgreich, wenn keine Daten verloren gehen. Andernfalls wird eine Warnung erzeugt.
    * Option --force kann verwendet werden, um Daten zu verändern -> gezieltes Löschen eines Commits, ...
    * force-with-lease ist besseres --force
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
    * option --force kann zum datenverändert verwendet werden -> gezieltes löschen eines Kommits, ...
    * force-with-lease ist besseres --force
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

***Vielen Dank für eure Aufmerksamkeit***