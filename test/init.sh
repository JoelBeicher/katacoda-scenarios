#!/bin/bash

docker container run -d \
    --name=postgres     \
    -p 5432:5432        \
    postgres:11.4

sudo apt-get update
sudo apt-get install postgresql-client
Y