```bash
docker container run -d \
    --name=postgres \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=secret \
    postgres:11.4
```{{execute}}

```
sudo apt-get install postgresql-client 
```{{execute}}

Nach dem alle Daten für den postgres-Client geladen wurde, erscheint zur Bestätigung der Installation die Frage: 
```
Do you want to continue? [Y/n]
```

Da wir Fortfahren wollen, um den Client auf der VM zu installieren beantworten wir mit: ` Y `{{execute}} was für Yes oder Ja steht.

Als nächstes wollen wir auf die postgres Instanz, die unter dem localen Port 5432 läuft, zugreifen. Das machen wir durch den folgenden Aufruf:
```
psql \
    -h localhost \
    -p 5432 \
    -u postgres
```{{execute}}
Mit der Meldung `Password for user postgres:` wird man aufgeforert, dass zuvor festgelgte Passwort einzugeben:
```
secret
```{{execute}}


