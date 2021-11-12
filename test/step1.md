```bash
docker container run -d \
    --name=postgres     \
    -p 5432:5432        \
    --no-password       \
    postgres:11.4
```{{execute}}

```
sudo apt-get update
sudo apt-get install postgresql-client 
```{{execute}}

Nach dem alle Daten für den postgres-Client geladen wurde, erscheint zur Bestätigung der Installation die Frage: 
```
Do you want to continue? [Y/n]
```

Da wir Fortfahren wollen, um den Client auf der VM zu installieren beantworten wir mit: ` Y `{{execute}} was für Yes oder Ja steht.

Als nächstes wollen wir auf die postgres-Instanz, die unter dem lokalen Port 5432 läuft, zugreifen. Das machen wir durch den folgenden Aufruf:
```
psql                \
    -h localhost    \
    -p 5432         \
    -U postgres
```{{execute}}
Mit der Meldung `Password for user postgres:` wird man aufgeforert, dass zuvor festgelgte Passwort einzugeben: `secret`{{execute}}

Jetzt sind wir bereit um auf unsere aktive postgres-Instanz zu zugreifen.  
Als nächstes benötigen wir eine Datenbank in welche wir unsere Daten importieren können.
Das wird über den `CREATE` Identifier durchgeführt:
`CREATE DATABASE dbname;`{{execute}}

Danach müssen wir uns nur noch mit der Datenbank verbinden. Dabei dient uns der `\connect` Command von postgres:
`\connect dbname`{{execute}}

Im weiteren werden wir uns anschauen wie man csv-Dateinen auf zwei unterschiedliche Arten importieren kann.
Ein effizenter Keyboard-Shortcut um die Inhalte im Terminal auf den neusten Eintrag zu reduzieren, kann mit  <kbd>Ctrl</kbd>+<kbd>L</kbd> ausgeführt werden. Der Shortcut kann auch über den Command `^L`{{execute ctrl-seq}} umgesetzt werden.