#!/bin/sh

#
# Starts a docker image with imagemagick as entrypoint
# you can use this script as if it be the imagemagick executable
# as long as you're in same directory than target image.
# NOTE: $PWD will be shared with container working directory
#
# For example:
# bash imagemagick.sh [ARGS]
#
# Consider add this script as an alias in ~/bash_aliases:
# alias convert='sh </path/to/scripts/imagemagick.sh>'
#

docker run -ti --rm -v "$PWD":/images -w /images -u 0 v4tech/imagemagick convert $@
