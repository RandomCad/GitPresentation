<!--compile with: pandoc --from=markdown+grid_tables --number-sections --to=pdf -o ~/test.pdf -V geometry:margin=1in -->
# Übungen
## Github Zugriff

Wer uns im voraus ihren Github Usernamen mitgeteilt hat, sollte auf das Übungs-Repository zugreifen können.
Alle andern können für die Übung "meinen" Account verwenden. 
Wenn ihr einen Push durchführen wollt und euch bei Github noch nicht angemeldet habt, werdet ihr nach Username und Password gefragt.
Dort ist folgendes einzugeben:

* Username: RandomCad
* Passwort: <todo>

## Lineares VCS
### Übung 1
Erstelle ein neues Repository mit `git init`.

Erzeugt mit `git status` eine Ausgabe, die folgendermaßen aussieht:

`##` \textcolor{green}{main}`...`\textcolor{red}{origin/main}

\textcolor{green}{M}\textcolor{red}{M}
`<some path>`

\textcolor{red}{A}\textcolor{red}{D}
`<some path>`

\textcolor{red}{!!} `<some path>`

### Übung 2
Aufgabe:
Erzeuge mehrere Commits, durch die die Optionen `-C -C -C` bei `git blame` und `--follow` bei `git log` eine Änderung in der Ausgabe bewirken.

### Übung 3 
* Erstelle einen fehlerhaften Commit
* Befinde ihn für so schlecht, dass du ihn mit einem neuen Commit rückgängig machst
* Befinde ihn für so schlecht, dass du beide Commits aus der Historie entfernst

### Übung 4

Ändere eine Datei in deinem Repository. 
Frage deinen Nachbarn nach einer neuen Änderung. Commite nur die Änderung deines Nachbarn mit `git commit -a`. 
Commite jetzt deine ursprüngliche Änderung. Deine History sollte wie folgt aussehen:

```
-<nachbarn commit>-<commit mit den vorherigen Änderungen>-
```

Was passiert, wenn dein Nachbar an der gleichen Stelle wie du Änderungen vornimmt?

## Branching & Remotes
### Übung 5
* Erstelle einen fehlerhaften Commit
* Verschiebe ihn an eine frühere Stelle der Versionshistorie (d.h. `A <- BAD <- B <- C (HEAD)`)
* korrigiere den Commit über `git rebase --autosquash`

### Übung 6
Verschiebe deine bisherigen änderungen mit `git branch -M <name>` auf einen Branch mit deinem namen. 
Füge den folgenden Server als Remote mit dem Namen `origin` hinzu:

* `ssh://git@github.com:RandomCad/Uebung_1.git`
* `https://github.com:RandomCad/Uebung_1.git`

Pushe nun deinen Branch auf den Server.

Beschaffe dir nun die aktuellsten Daten vom Server. 
Hat dieser noch andere Branches als deine eigene? 
Schau dir einige von diesen an versuche dazu unterschiedliche Kommandos zu wechseln zu verwenden.

### Übung 7
Versuche Branches deiner Kommilitonen mit deinen eigenen zu vereinen. 
Probiere dafür sowohl Merging als auch Rebasing aus. 
Versuche auch eine einzelne Änderung in deine Branch einzuführen.

## Zusatz
Clone das LLVM Repository und verbrauche dabei so wenig Speicher für Git wie möglich. 
Wir möchten aber dazu fähig sein LLVM in der aktuellsten Version zu Kompilieren (Version 16 aufwärts)

