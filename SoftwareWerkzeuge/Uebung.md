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
Vorraussetzungen: `git status`, `git add`, .gitignore

Erzeugt mit `git status` eine Ausgabe, die folgendermaßen aussieht:

[//]: # "<code> block used to get colors"
<code>
## <font color="green">main</font>...<font color="red">origin/main</font><br>
<font color="green">M</font><font color="red">M</font>
&lt;some path&gt;<br>
<font color="green">A</font><font color="red">D</font>
&lt;some path&gt;<br>
<font color="red">!!</font> &lt;some path&gt;
</code>

::: notes Lösung
- File1 ändern, File2 hinzufügen
- git add File1 File2
- File1 ändern, File2 löschen
- File3 anlegen & zu .gitignore hinzufügen
- git status --ignored -sb
:::

### Übung 2
Vorraussettzungen: `git show`, `git log`

Vorbereitung:
- commit der 2 funktionen (A und B) hinzufügt
- eine funktion wird mehrfach geändert (u.a. umbenannt, in andere Datei verschoben etc.)

Aufgabe:
Finde die Funktion, welche zusammen mit Funktion A committed wurde

Lösung:
- git blame -C -C -C -L :funcname path/to/file
- ältesten commit suchen
- git show &lt;commit&gt;
