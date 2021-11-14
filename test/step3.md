Dieser Teil geht auf die Exportierung schon vorhandener Datenbanktabellen ein.

## CSV
Um beispielsweise die simple_imdb Datenbanktabelle nach CSV zu exportieren wird auch der `psql \copy` Befehl verwendet, jedoch mit dem Identifier `TO`, da die Daten in die angegebene Exportdatei gespeichert werden.
```
\copy simple_imdb TO 'IMDB-stats-export.csv' DELIMITER '|' CSV HEADER;
```{{execute}}

In diesem Fall wird eine Pipe als Trennzeichen verwendet. Wie können die nun erstellte Datei betrachten, in dem wir die postgres-Instanz mit `\q`{{execute}} beenden, und die Exportdatei mit `cat IMDB-stats-export.csv`{{execute}} betrachten.

## JSON
Da viele Anwendungen davon profitieren, wenn Daten in einem Key-Value Format zu Verfügung stehen, biete postgresql Aggregationsfunktionen wie `json_agg()` an um Datenbanktabellen effizient in das JSON-Format zu exportieren.

```json
[
    {
        "id":1,
        "title":"The Shawshank Redemption",
        "year":1994,
        "rated":"R",
        "genre":"Crime, Drama"
    },
    ...
    {
        "id":250,
        "title":"Slumdog Millionaire",
        "year":2008,
        "rated":"R",
        "genre":"Drama" 
    }
]
```

Da wir von vorneherein gewährleisten möchten, dass wir eine valide JSON-Datei erstellen, müssen in der postgres-Instanz `psql dbname -h localhost -p 5432 -U postgres`{{execute}} zwei Flags gesetzt werden. Zum Einen wird die "Tupels Only" Flag aktiviert - `\t on`{{execute}} - um die Spalten Bezeichnungen zu entfernen. Diese werden überflüssig, da sie für jede Reihe als Key-Identifier gespeichert werden.
Zum Anderen setzen wir das Formatting auf `unaligned` um nicht vailde Abstandsbezeichner zu entfernen: 
`\pset format unaligned`{{execute}}

Nun können wir die Datenbanktabelle durch den Befehl:
`SELECT json_agg(s) FROM simple_imdb s \g IMDB-stats-export.json;`{{execute}}
exportieren. Anstelle der kompletten Datenbanktabelle, können an dieser Stelle auch erweiterte `SELECT` Statements Untertabellen exportiert werden. 

Die exportierten Daten können nun wieder außerhalb der postgres-Instanz `\q`{{execute}} unter `cat IMDB-stats-export.json` betrachtet werden.

Wie kann man jedoch aus einer JSON-Datei eine Datenbanktabelle erstellen und befüllen?
Das werden wir im nächsten Step behandelt.