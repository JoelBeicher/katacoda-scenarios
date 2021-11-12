Text text Text text Text text Text text Text text Text text Text text Text text

## Manuelle Importierung
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

```
\copy simple_imdb(id, title, year, rated, genre) FROM 'IMDB-stats-simple.csv' csv header;
```{{execute}}

## Automatische Importierung

Text bla nal nla bla: `\quit`{{execute}}

Wenn wir nun versuchen würden die original Datei mit 30 Spalten importieren zu wollen, stellen wir schnell fest, dass wir viele neue Spalten manuelle zu unserer Datenbank Tabelle hinzufügen müssten. Um diesen Schritt zu vereinfachen, gibt es vorgefertigte Packete - unter anderem `pgfutter`.
Das Packet kann durch den Command:
```
wget -O pgfutter https://github.com/lukasmartinelli/pgfutter/releases/download/v1.2/pgfutter_linux_amd64
```{{execute}}
heruntergeladen werden. Damit das Packet ausgeführt werden kann, müssen laut Dokumentation [zitat] die Rechte zum Ausführen vom Benutzer vergeben werden. Die Rechte können durch den Befehl `chmod +x ./pgfutter`{{execute}}, der für "Change mode" steht, verändert werden.

Danach kann durch den folgenden Befehl, auf das gerade heruntergeladene Packet, eine neue Tabelle `imdb` zur Datenbank `dbname` mit den Inhalten aus der Original Datei `IMDB-stats.csv` hinzugefügt werden:
```
./pgfutter              \
    --db dbname         \
    --pw secret         \
    --table imdb        \
    csv IMDB-stats.csv
```{{execute}}

Dadurch wird in einem Schritt durch den `header` der CSV-Datei eine Tabelle mit Spalten angelegt und die restlichen Daten der Datei importiert. Bei erfolgreicher Durchführung sollte `COPY 250` erscheinen, was bedeutet, dass 250 Einträge nun in der Tabelle `import.imdb` gespeichert wurden. Im Gegensatz zur `imdb` Tabelle besitzt die `import.imdb` Tabelle keinen spezifischen Typ oder Constrains. Das zeigt die Aufzählung der Spalten und ihre Typen anhand des Commands: `\d+ import.imdb`{{execute}}. Man erkennt, dass alle Spalten den Typ `text` erhalten haben, der eine variable Anzahl an Zeichen bis zu 2GB zulässt.
  