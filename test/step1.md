Der erste Schritt besteht darin, dass ein postgresql Docker-Container heruntergeladen wird. 

```bash
docker container run -d \
    --name=postgres     \
    -p 5432:5432        \
    postgres:11.4
```{{execute}}
Wir starten den postgresql-Container mit den Instantiierungsparametern für den Benuzter postgres und laden im Anschluss eine postgresql-Client über:
```
sudo apt-get update
sudo apt-get install postgresql-client 
```{{execute}}
herunter, der es uns ermöglicht eine lokale Verbindung zur Instanz herzustellen.
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
  
Als nächstes benötigen wir eine Datenbank in welche wir unsere Daten importieren können.
Das wird über den `CREATE` Identifier durchgeführt:
`CREATE DATABASE dbname;`{{execute}}

Danach müssen wir uns nur noch mit der Datenbank verbinden. Dabei dient uns der `\connect` Command von postgres:
`\connect dbname`{{execute}}

Im weiteren werden wir uns anschauen wie man csv-Dateinen auf zwei unterschiedliche Arten importieren kann.
Ein effizenter Keyboard-Shortcut um die Inhalte im Terminal auf den neusten Eintrag zu reduzieren, kann mit  <kbd>Ctrl</kbd>+<kbd>L</kbd> ausgeführt werden. Der Shortcut kann auch über den Command `\! clear`{{execute}} in postgresql und über `clear`{{execute}} in bash-Terminal umgesetzt werden.