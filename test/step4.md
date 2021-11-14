Auch die Importierung von JSON-Daten in eine Datenbank kann in eine manuelle und eine automatische Importierung unterteilt werden. Bei der automatischen Importierung wird wie bei den CSV-Daten das `pgfutter` Paket verwendet, dass wir im Schritt 2 schon heruntergeladen haben.

## Manuelle Importierung

Die Vorgehensweise zur erfolgreichen manuellen Importierung kann anhand 3 Schritten beschrieben werden.

Zunächst wird die valide JSON-Datei, die ein Array `[...]` mit allen Inhalten enthält bearbeitet, um in den darauffolgenden Schritten von der Aggregationsfunktion `json_populate_recode()` von postgresql verwendet werden zu können. Es ist notwendig die eckigen Klammern `[]`, `\t`, `\n` und die Kommas zwischen den Einträgen pro Reihe zu entfernen. Auch werden die veränderten Daten in eine neue Datei geschrieben. In unserem Fall nennen wir die neue Datei `IMDB-stats-export-min.json` und für folgenden Befehl aus:

```
cat IMDB-stats-export.json | jq -cr '.[]' | sed 's/\\[tn]//g' > IMDB-stats-export-min.json
```{{execute}}

Der nächste Schritt ist die Erstellung einer temporären Datenbanktabellle auf der Instanz `psql dbname -h localhost -p 5432 -U postgres`{{execute}}, in welche die minimierte JSON-Datei als ganzes in eine Spalte gespeichert wird:

```
CREATE TABLE tmp (c text);
\copy tmp from 'IMDB-stats-export-min.json'
```{{execute}}

Der letzte Schritt beinhaltet das Einfügen der eigentlichen Spalten und Reihen in die Datenbanktablle `simple_imdb`, die über den folgenden Aufruf neu erstellt werden kann:

```postgres
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

Hierbei wird die schon beschriebene `json_populate_record()` Funktion verwendet. Sie kann JSON-Konstrukte, wie einzelne Key-Value-Paare zu ihren übereinstimmenden Spalteneinträge in der `simple_imdb` Tabelle hinzufügen.

```
INSERT INTO simple_imdb
SELECT q.* FROM tmp, json_populate_record(null::simple_imdb, c::json) AS q;
```{{execute}}

`null::simple_imdb` wird als polymorphische Funktion verwendet um alle Typen der vorhandenen Spalten in der `simple_imdb` Tabelle bearbeiten zu können. Somit müssen wir nicht alle Spalten Name und Typen nochmal von Hand eintragen.
Der `c::json` Parameter nimmt die Spalte `c` aus der temporären Tabelle `tmp` und konvertiert den Inhalt zum `json` Typ.

Der Aufruf `SELECT * FROM simple_imdb WHERE year = 2000;` sollte folgende Daten aufweißen:


Das zeigt das alle Daten erfolgreich importiert wurden.

## Automatische Importierung

Schauen wir uns nun die Importierung unserer JSON-Daten über `pgfutter` an.
