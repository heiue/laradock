#!bin/bash

docker-compose down &&
# docker-compose build  nginx  php-fpm workspace   &&
docker-compose up -d nginx

