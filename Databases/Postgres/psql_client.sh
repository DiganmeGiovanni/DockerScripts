#!/bin/bash
#
# Creates a new postgres docker container
# and runs psql
# Check: https://github.com/docker-library/docs/blob/master/postgres/README.md
# for extra info
#
# NOTE: By default current dir $(pwd) will be mounted into
# /var/lib/postgresql/data inside container
#
# Tip: Setup an alias to this script to use it from command line
docker run -it --rm \
    --network host \
    -v $(pwd):/var/lib/postgresql/data \
    -w /var/lib/postgresql/data \
    postgres:9.6.20-alpine \
    psql $@
