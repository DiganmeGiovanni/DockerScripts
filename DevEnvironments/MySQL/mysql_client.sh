#!/bin/bash
#
# Creates a new mysql client docker container
# Checkout: https://hub.docker.com/_/mysql for extra info
#
# Tip: Setup an alias to this script to use from command line
docker run -it --rm mysql $@
