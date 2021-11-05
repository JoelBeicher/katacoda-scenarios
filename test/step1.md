```bash
docker container run -d \
    --name=postgres \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=password \
    postgres:11.4
```{{execute}}

```
sudo apt-get install postgresql-client 
```{{execute}}

Nach dem alle Daten für den postgres-Client geladen wurde, erscheint zur Bestätigung der Installation die Frage: 
```
Do you want to continue? [Y/n]
```

Da wir Fortfahren wollen, um den Client auf der VM zu installieren beantworten wir mit: ` Y `{{execute}}

```
Password for user postgres:
```