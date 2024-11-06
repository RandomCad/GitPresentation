<!--compile with: pandoc --from=markdown+grid_tables --number-sections --to=pdf -o ~/test.pdf -V geometry:margin=1in -->
# Übung
## Github Zugriff

Wer uns im voraus ihren Github Usernamen mitgeteilt hat, sollte auf das Übungs-Repository zugreifen können.
Alle andern können für die Übung "meinen" Account verwenden. 
Wenn ihr einen Push durchführen wollt und euch bei Github noch nicht angemeldet habt, werdet ihr nach Username und Password gefragt.
Dort ist folgendes einzugeben:
- Username: RandomCad
- Passwort: <todo>

## Lineares VCS
### Übung 1
Erstelle ein neues Repository mit `git init`.

Erzeugt mit `git status` eine Ausgabe, die folgendermaßen aussieht:

<code>
## <font color="green">main</font>...<font color="red">origin/main</font><br>
<font color="green">M</font><font color="red">M</font>
&lt;some path&gt;<br>
<font color="green">A</font><font color="red">D</font>
&lt;some path&gt;<br>
<font color="red">!!</font> &lt;some path&gt;
</code>

### Übung 2
Aufgabe:
Erzeuge mehrere Commits, durch die die Optionen `-C -C -C` bei `git blame` und `--follow` bei `git log` eine Änderung in der Ausgabe bewirken.

# Übung 3 
- commit1
- commit2, der commit1 rückgängig macht
- beide commits aus history entfernen

# Übung 4

Ändere eine Datei in deinem Repository. 
Frage deinen Nachbarn nach einer neuen Änderung. Commit nur die Änderung deines Nachbarn mit commit -a. 
Commit jetzt deine ursprüngliche Änderung. Deine History sollte wie folgt aussehen:

```
-<nachbarn commit>-<commit mit den vorherigen Änderungen>-
```

Was passiert, wenn dein Nachbar an der gleichen Stelle wie du Änderungen vornimmt?

# Übung 5
Verschiebe deine bisherigen änderungen mit `git branch -M <name>` auf einen Branch mit deinem namen. 
Füge den folgenden Server als Remote mit dem Namen `origin` hinzu:
git@github.com:RandomCad/Uebung_1.git
pushe nun deine branch auf den server.

Beschaffe dir nun die aktuellsten daten vom Server. 
Hat dieser noch andere Branches als deine eigene? 
Schau dir einige von diesen an versuche dazu unterschiedliche Commandos zu wechseln zu verwenden.

# Übung 6
Entscheide dich für eine Interesante Branch aus Übung 5. 
Merge die änderungen in dieser branch in deine eigen Branch hinein. 
Pushe das ergebniss mit auf den server.

# Übung 7
Verwende nun rebase um deine Änderungen auf eine Dritte Branch zu rebasen. 
Pushe erneut das ergebniss.


