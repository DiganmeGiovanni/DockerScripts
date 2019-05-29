#!/bin/bash

# *************************************************************************
# Created on: Sat, Jun 13, 2015
# @author Giovanni Aguire | @DiganmeGiovanni
#
# Create and run a mongodb container based on official image
# -------------------------------------------------------------------------
#
# 1. Ask to the user for a name for container
# 2. Ask to the user for a local port to mapping container 27017 to
# 3. Ask to the user for a local port to mapping container 28017 to
# 4. Ask to the user for a password to set to mongodb
#

CONTAINER_NAME="mongodb"
LOCAL_MONGODB_PORT="27017"
LOCAL_HTTPINTERFACE_PORT="28017"
MONGODB_PASSWORD="root"
DOCKER_IMAGE_TAG="latest"

# Asking for container's name
echo
echo "Write a valid name for the new container."
read -p  "Container name[mongodb]: " TMP_CONTNAME
if ! [ -z "$TMP_CONTNAME" ];
then
  CONTAINER_NAME=$TMP_CONTNAME
fi
echo "  Name for container will be: $CONTAINER_NAME"


# Local port for mapping instance 27017
echo
echo "On which local port should the container map the container's instance port?"
read -p "Local port to access database[27017]: " LOCAL_PORT
if ! [ -z "$LOCAL_PORT" ];
then
    LOCAL_MYSQL_PORT=$LOCAL_PORT
fi
echo " Mapping container port [27017] to local port [$LOCAL_MONGODB_PORT]"

# Local port for mapping instance 28017 [HTTP INTERFACE PORT]
echo
echo "On which local port should the container map the container's http interface port?"
read -p "Local port to access database[28017]: " LOCAL_PORT2
if ! [ -z "$LOCAL_PORT2" ];
then
    LOCAL_HTTPINTERFACE_PORT=$LOCAL_PORT2
fi
echo " Mapping container port [28017] to local port [$LOCAL_HTTPINTERFACE_PORT]"

# Ask for a password for mongodb database
echo
echo "Write a password for the mongodb instance [empty defaults to 'root']"
read -s -p "Password: " TMP_PASSWORD
if ! [ -z "$TMP_PASSWORD" ];
then
    MONGODB_PASSWORD=$TMP_PASSWORD
fi

# Ask for docker image tag
echo
echo "Which docker image tag should the container use?"
read -p "Docker image tag [latest]: " TMP_TAG
if ! [ -z "$TMP_TAG" ]; then
    DOCKER_IMAGE_TAG=$TMP_TAG
fi
echo "Using image tag [$DOCKER_IMAGE_TAG]"

# Ask for custom data dir
echo
echo "Indicate a local route where to store data (If empty data will be stored on container)"
read -p " Data directory: " DATA_DIR
if ! [ -z "$DATA_DIR" ];
then
    CUSTOM_DATA_DIR=true
fi

## Assemble command
DOCKER_COMMAND="docker run -ti  -p $LOCAL_MONGODB_PORT:27017 "
DOCKER_COMMAND="$DOCKER_COMMAND -p $LOCAL_HTTPINTERFACE_PORT:28017 "
DOCKER_COMMAND="$DOCKER_COMMAND --name $CONTAINER_NAME "
if $CUSTOM_DATA_DIR ; then
    DOCKER_COMMAND="$DOCKER_COMMAND -v $DATA_DIR:/data/db"
fi
DOCKER_COMMAND="$DOCKER_COMMAND -e MONGO_INITDB_ROOT_USERNAME=root "
DOCKER_COMMAND="$DOCKER_COMMAND -e MONGO_INITDB_ROOT_PASSWORD=$MONGODB_PASSWORD"
DOCKER_COMMAND="$DOCKER_COMMAND -d mongo:$DOCKER_IMAGE_TAG"

## Create and start container
echo
echo "Creating container with command:"
echo $DOCKER_COMMAND
eval $DOCKER_COMMAND 

echo
echo "Container start successfully"
