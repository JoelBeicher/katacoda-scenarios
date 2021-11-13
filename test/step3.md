Dieser Teil geht auf die Exportierung schon vorhandener Datenbanktabellen ein.

```
\copy simple_imdb 
TO 'IMDB-stats-export.csv' 
DELIMITER ',' CSV HEADER;
```{{execute}}