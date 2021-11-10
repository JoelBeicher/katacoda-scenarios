### Manuelle Importierung ###
```
DROP TABLE imdb IF EXISTS;  \
CREATE TABLE imdb (         \
    id SERIAL,              \
    title VARCHAR(255),     \
    year DATE,              \ 
    genre VARCHAR(255),     \
    PRIMARY KEY (id)        \
);
```{{execute}}

Text bla nal nla bla: `\quit`{{execute}}

```
psql dbname                             \
    -h localhost                        \ 
    -p 5432                             \
    -U postgres                         \ 
    -c "                                \
        COPY imdb(title, year, genre)   \
        FROM 'IMDB-stats-simple.csv'    \    
        delimiter ',' csv               \
    "
```{{execute}}

```
wget -O pgfutter https://github.com/lukasmartinelli/pgfutter/releases/download/v1.2/pgfutter_linux_amd64
```{{execute}}