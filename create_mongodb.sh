#!/bin/bash

# *************************************************************************
# Created on: Sat, Jun 13, 2015
# @author Giovanni Aguire | @DiganmeGiovanni
#
# Create and run a mongodb container based on image 'tutum/mongodb:3.0'
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

## Create and start container
echo
echo
echo "Creating container with command:"
echo "docker run -t -i -p $LOCAL_MONGODB_PORT:27017 -p $LOCAL_HTTPINTERFACE_PORT:28017 --name $CONTAINER_NAME -e MONGODB_PASS=$MONGODB_PASSWORD tutum/mongodb:3.0"

echo
echo "executing command ..."
docker run -t -i -p $LOCAL_MONGODB_PORT:27017 -p $LOCAL_HTTPINTERFACE_PORT:28017 --name $CONTAINER_NAME -e MONGODB_PASS=$MONGODB_PASSWORD tutum/mongodb:3.0 /bin/bash
