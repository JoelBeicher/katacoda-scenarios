Dieser Teil beschreibt einmal wie man manuell Datenbanktabelle anlegt und sie dann mit den entsprechenden Daten befüllt. Zum Anderen wird auch die automatische Importierung in nicht vorbereitete Datenbanktabelle anhand von externen Paketen thematisiert.

## Manuelle Importierung

Der erste Schritt um Daten aus einer CSV-Datei zu importieren, beeinhaltet das Anlegen einer neuen Datenbanktabelle:
```
DROP TABLE IF EXISTS simple_imdb;
CREATE TABLE simple_imdb (
    id SERIAL,
    title VARCHAR(255),
    year INT,
    rated VARCHAR(255),
    genre VARCHAR(255),
    PRIMARY KEY (id)
);
```{{execute}}
Hierbei können wir beliebige Typisierungen, Constrains und Regeln verwenden. Im nächste Schritt, kopieren wir die Daten der CSV-Datei ohne den `header` - also die Bezeichung der Spalten - in unsere vorbereitete `simple_imdb` Tabelle:
```
\copy simple_imdb(id, title, year, rated, genre) FROM 'IMDB-stats-simple.csv' csv header;
```{{execute}}
Nach erfolgreicher Importierung sollte erscheinen, dass 250 Einträge kopiert wurden: `COPY 250`.
Lässt man sich nun alle Inhalte der Tabelle, durch den Befehl `SELECT * FROM simple_imdb;` anzeigen, erhält man alle Einträge der Tabelle: 

 id  |           title            | year |   rated   |         genre       
-----+----------------------------+------+-----------+------------------------
   1 | The Shawshank Redemption   | 1994 | R         | Crime, Drama
   2 | The Godfather              | 1972 | R         | Crime, Drama
   3 | The Godfather: Part II     | 1974 | R         | Crime, Drama
   4 | The Dark Knight            | 2008 | PG-13     | Action, Crime, Drama
   5 | 12 Angry Men               | 1957 | APPROVED  | Crime, Drama
 ... | ...                        | ...  | ...       | ...
 245 | Patton                     | 1970 | GP        | Biography, Drama, War
 246 | The Lost Weekend           | 1945 | NOT RATED | Drama, Film-Noir
 247 | Short Term 12              | 2013 | R         | Drama
 248 | His Girl Friday            | 1940 | APPROVED  | Comedy, Drama, Romance
 249 | The Straight Story         | 1999 | G         | Biography, Drama
 250 | Slumdog Millionaire        | 2008 | R         | Drama
 
 
Wenn wir nun versuchen würden die original Datei mit 38 Spalten importieren zu wollen, stellen wir schnell fest, dass wir viele neue Spalten manuelle zu unserer Datenbank Tabelle hinzufügen müssten. Deshalb wäre eine verallgemeinerte Importierung mit automatischem Anlegen einer Datenbanktabelle hilfreich.

## Automatische Importierung

Um eine automatische Importierung durchzuführen, kann man auf vorgefertigte Pakete - unter anderem `pgfutter` zurückgreifen. Da das Paket außerhalb der postgres-Instanz heruntergeladen werden muss, kann man durch den Befehl `\quit`{{execute}} die Instanz verlassen.
`pgfutter` wird über den folgenden Befehl ausgeführt:
```
wget -O pgfutter https://github.com/lukasmartinelli/pgfutter/releases/download/v1.2/pgfutter_linux_amd64
```{{execute}}
Damit das Paket ausgeführt werden kann, müssen laut Dokumentation [zitat] die Rechte zum Ausführen vom Benutzer vergeben werden. Die Rechte können durch den Befehl `chmod +x ./pgfutter`{{execute}}, der für "Change mode" steht, verändert werden.

Danach kann durch den nächsten Befehl, auf das gerade heruntergeladene Packet, eine neue Tabelle `imdb` zur Datenbank `dbname` mit den Inhalten aus der Original Datei `IMDB-stats.csv` hinzugefügt werden:
```
./pgfutter              \
    --db dbname         \
    --pw secret         \
    --table imdb        \
    csv IMDB-stats.csv
```{{execute}}

Dadurch wird in einem Schritt durch den `header` der CSV-Datei eine Tabelle mit Spalten angelegt und die restlichen Daten der Datei importiert. Bei erfolgreicher Durchführung sollte `38 columns` und `250 rows imported into import.imdb` erscheinen, was bedeutet, dass 38 Spalten mit 250 Einträge nun in der Tabelle `import.imdb` gespeichert wurden. Im Gegensatz zur `imdb` Tabelle besitzt die `import.imdb` Tabelle keinen spezifischen Typ oder Constrains. Das zeigt die Aufzählung der Spalten und ihre Typen anhand des Befehls: `\d+ import.imdb`{{execute}}. Man erkennt, dass alle Spalten den Typ `text` erhalten haben, der eine variable Anzahl an Zeichen bis zu 2GB zulässt.
  