#!/bin/sh

#
# Starts a docker image with composer included, you can use this
# script as if it be the composer binary, For example:
# sh ./composer.sh create-project --prefer-dist laravel/laravel MYAPP
#
# Consider add this script as an alias in ~/bash_aliases:
# alias composer='sh </path/to/scripts/composer.sh>'
#
# For advanced documentation check: https://hub.docker.com/_/composer/
docker run -ti --rm -v $PWD:/app composer:1.7.3 $@
