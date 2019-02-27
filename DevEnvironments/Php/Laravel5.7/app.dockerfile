FROM php:7.2-fpm-alpine3.9

# RUN apt-get update \
#     && apt-get install -y libmcrypt-dev libxml2-dev mysql-client \
#     && pecl install mcrypt-1.0.1 \
#     && docker-php-ext-enable mcrypt \
#     && docker-php-ext-install \
#         mbstring \
#         pdo \
#         pdo_mysql \
#         tokenizer \
#         xml
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

