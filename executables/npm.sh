#!/bin/sh

#
# Starts a docker image with node:alpine included and runs npm by default,
# you can use this
# script as if it be the node binary, For example:
# sh npm.sh run watch-poll
#
# Consider add this script as an alias in ~/bash_aliases:
# alias npm='sh </path/to/scripts/npm.sh>'
#
# For advanced documentation check: https://hub.docker.com/_/node/
#

docker run -ti --rm -v $PWD:/app -w /app -u 0 node:alpine npm $@