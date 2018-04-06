#!/bin/sh

##
## This is the original script taken from https://hub.docker.com/r/composer/composer/

# export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
# echo "Current working directory: '"$(pwd)"'"
# docker run --rm -v $(pwd):/app -v ~/.ssh:/root/.ssh composer/composer $@

##
## Instead I only use:
docker run --rm -v /home/giovanni/Sources/Php/TEAProjectManager:/app -v ~/.ssh:/root/.ssh composer/composer $@

## 
## Now execute this script as if it be the composer binary
## For example:
## sh ./composer.sh create-project --prefer-dist laravel/laravel MYAPP
