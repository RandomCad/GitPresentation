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
