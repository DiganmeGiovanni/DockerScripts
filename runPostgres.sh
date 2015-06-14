# *******************************************************
# This script creates a docker container based on image
# 'postgres' and activate port mapping
#
#
# Start the container with a '/bin/bash' console

DOCKER_IMAGE='postgres:9.4'
CONTAINER_NAME='postgres'

sudo docker run -t -i -p 5432:5432 --name $CONTAINER_NAME -e POSTGRES_PASSWORD=postgres $DOCKER_IMAGE /bin/bash
