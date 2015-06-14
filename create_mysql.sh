#!/bin/bash

# *************************************************************
# Created on: Sat, Jun 13, 2015
# @author Giovanni Aguire | @DiganmeGiovanni
#
# Create and run a mysql container based on image 'mysql:5.7'
# 
# 1. Ask to the user for a name for container
# 2. Ask to the user for a local port to mapping container 3306 to
# 3. Ask to the user for a password to set to mysql instance
#

CONTAINER_NAME="dmysql"
LOCAL_MYSQL_PORT="3306"
MYSQL_ROOT_PASSWORD="root"

# Asking for container's name
echo
echo "Write a valid name for the new container."
read -p  "Container name[dmysql]: " TMP_CONTNAME
if ! [ -z "$TMP_CONTNAME" ];
then
  CONTAINER_NAME=$TMP_CONTNAME
fi
echo "  Name for container will be: $CONTAINER_NAME"

# Local port for mapping instance
echo
echo "On which local port should the container map the container's instance port?"
read -p "Local port to access database[3306]: " LOCAL_PORT
if ! [ -z "$LOCAL_PORT" ];
then
    LOCAL_MYSQL_PORT=$LOCAL_PORT
fi
echo " Mapping container port [3306] to local port [$LOCAL_MYSQL_PORT]"

# Ask for a root password for instance
echo
echo "Write a root password for the mysql instance [empty defaults to 'root']"
read -s -p "Password: " TMP_PASSWORD
if ! [ -z "$TMP_PASSWORD" ];
then
    MYSQL_ROOT_PASSWORD=$TMP_PASSWORD
fi

## Create and start container
echo
echo "Creating container with command:"
echo "docker run -t -i -p $LOCAL_MYSQL_PORT:3306 --name $CONTAINER_NAME -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -d mysql:5.7"
echo
echo "executing command ..."
docker run -t -i -p $LOCAL_MYSQL_PORT:3306 --name $CONTAINER_NAME -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -d mysql:5.7

echo "Container started successfully"
