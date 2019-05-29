#!/bin/sh

#
# Starts a docker image with node:alpine included, you can use this
# script as if it be the node binary, For example:
# sh .node.sh npm run watch-poll
#
# Consider add this script as an alias in ~/bash_aliases:
# alias node='sh </path/to/scripts/node.sh>'
#
# For advanced documentation check: https://hub.docker.com/_/node/
#

docker run -ti --rm -v $PWD:/app -w /app -u "node" node:alpine $@