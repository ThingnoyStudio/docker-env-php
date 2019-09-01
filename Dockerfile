# base image
FROM php:5.6-apache

# label
LABEL MAINTAINER="skypart@test.mail"

# environment variable
ENV ENVIRONMENT=prod

RUN echo ${ENVIRONMENT}

# run command
# execute on build image
RUN echo "[PHP] \ndate.timezone = Asia/Bangkok" >> /usr/local/etc/php/php.ini

RUN apt-get update \
    && apt-get install -y libgd-dev \
    && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install mysqli gd

RUN a2enmod rewrite

# copy
COPY ./php_info.php /var/www/html/index.php

# /var/lib/docker/volumes/repo/_data
VOLUME [ "/var/www/html" ]

# work directoty
WORKDIR /var/www/html

# map private port to external
EXPOSE 80 443