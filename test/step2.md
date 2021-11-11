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

Text bla nal nla bla: `\quit`{{execute}}

```

```{{execute}}

```
wget -O pgfutter https://github.com/lukasmartinelli/pgfutter/releases/download/v1.2/pgfutter_linux_amd64
```{{execute}}