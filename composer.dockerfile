FROM composer:latest

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel
RUN addgroup --gid 1001 meinteresa && adduser --gid 1000 --shell /bin/sh --no-create-home meinteresa

WORKDIR /var/www/html