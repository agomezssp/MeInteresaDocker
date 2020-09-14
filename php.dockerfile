#FROM php:7.4-fpm-alpine
FROM php:7.4-fpm
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html

RUN chown laravel:laravel /var/www/html

WORKDIR /var/www/html
ADD ./src /var/www/html
RUN docker-php-ext-install pdo pdo_mysql
#RUN setenforce 0
RUN sed -ri 's/^www-data:x:82:82:/www-data:x:1000:50:/' /etc/passwd
RUN chown -R www-data:www-data /var/www/html \
    && chmod 777 -R /var/www/html
#RUN chcon -R -h system_u:object_r:bin_t:s0 /var/www/html/storage/*
#RUN chcon -R -t httpd_sys_rw_content_t /var/www/html/storage/
