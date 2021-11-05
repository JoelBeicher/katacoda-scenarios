```
docker container run 
    -d 
    --name=postgres 
    -p 5432:5432 
    -e POSTGRES_PASSWORD=password
    postgres:11.4 {{execute T1}}
```

```
sudo apt-get install postgresql-client {{execute T1}}
```

```
Do you want to continue? [Y/n]
```

```
Password for user postgres:
```

