FROM php:7.2-fpm-alpine3.9

RUN apk --update add \
                libxml2-dev \
                php7-bcmath \
                php7-ctype \
                php7-json \
                php7-mbstring \ 
                php7-openssl \
                php7-pdo \
                php7-pdo_mysql \
                php7-tokenizer \
                php7-xml \
                php7-xmlreader \
                php7-xmlwriter \
        && docker-php-ext-install \
                mbstring \
                pdo \
                pdo_mysql \
                tokenizer \
                xml \
        && rm -rf /var/cache/apk/*

WORKDIR /var/www
