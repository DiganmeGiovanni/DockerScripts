#!/bin/sh

##
## Check this link for ducumentation about docker image and newest versions
## https://github.com/mtmacdonald/docker-laravel

# Replace '/home/app' with your application route
docker run -d \
    -p 80:80 -p 443:443 \
    -v /home/giovanni/Sources/Php/TEAProjectManager:/share \
    --restart=always \
    --name=appname \
    mtmacdonald/docker-laravel:1.4.0
