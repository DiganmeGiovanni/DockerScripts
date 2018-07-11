#!/bin/bash

# *************************************************************
# Created on: Sat, Jun 13, 2015
# @author Giovanni Aguire | @DiganmeGiovanni
#
# Create and run a mysql server container
# 
# 1. Ask to user for a name for container
# 2. Ask to user for a local port to mapping container 3306 to
# 3. Ask to user for a password to set to mysql instance
# 4. Ask to user for default database name
# 5. Ask to user for the MySQL server version to use on container
#

CONTAINER_NAME="dmysql"
MYSQL_LOCAL_PORT="3306"
MYSQL_ROOT_PASSWORD="root"
MYSQL_DATABASE="default"
MYSQL_VERSION="latest"
MYSQL_AVAILABLE_VERSIONS="[latest, 8.0.11, 8.0, 8, | 5.7.22, 5.7, 5 | 5.6.40, 5.6]"
DOCKER_COMMAND="docker run -ti"

# Asking for container's name
echo
echo "Write a valid name for the new container, default is 'dmysql'"
read -p  "Container name: " TMP_CONTNAME
if ! [ -z "$TMP_CONTNAME" ];
then
  CONTAINER_NAME=$TMP_CONTNAME
fi
echo "  Name for container will be: $CONTAINER_NAME"

# Local port for mapping instance
echo
echo "On which local port should the container map the container's instance port? Default is '3306'"
read -p "Local port to access database: " LOCAL_PORT
if ! [ -z "$LOCAL_PORT" ];
then
    MYSQL_LOCAL_PORT=$LOCAL_PORT
fi
echo " Mapping container port [3306] to local port [$MYSQL_LOCAL_PORT]"

# Ask for a root password for instance
echo
echo "Write a root password for the mysql instance [empty defaults to 'root']"
read -p "Password: " TMP_PASSWORD
if ! [ -z "$TMP_PASSWORD" ];
then
    MYSQL_ROOT_PASSWORD=$TMP_PASSWORD
fi

# Ask for a default database to be created
echo
echo "Default database to be created. Default is 'default': "
read -p "Default database name: " TMP_DEFAULT_DATABASE
if ! [ -z "$TMP_DEFAULT_DATABASE" ];
then
    MYSQL_DATABASE=$TMP_DEFAULT_DATABASE
fi
echo " Name for default database will be: $MYSQL_DATABASE"

# Ask for a mysql version to be used
echo
echo "Which mysql version should be used? Default is [latest]: "
echo " Available options are: $MYSQL_AVAILABLE_VERSIONS "
read -p " MySQL server version: " TMP_DEFAULT_VERSION
if ! [ -z "$TMP_DEFAULT_VERSION" ];
then
    MYSQL_VERSION=$TMP_DEFAULT_VERSION
fi
echo " MySQL server version will be: $MYSQL_VERSION"

## Assembly command
DOCKER_COMMAND="$DOCKER_COMMAND -p $MYSQL_LOCAL_PORT:3306 "
DOCKER_COMMAND="$DOCKER_COMMAND --name $CONTAINER_NAME "
DOCKER_COMMAND="$DOCKER_COMMAND -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD "
DOCKER_COMMAND="$DOCKER_COMMAND -e MYSQL_DATABASE=$MYSQL_DATABASE "
DOCKER_COMMAND="$DOCKER_COMMAND -d mysql:$MYSQL_VERSION"

## Create and start container
echo
echo "Creating container with command:"
echo $DOCKER_COMMAND
echo
echo "executing command ..."
eval $DOCKER_COMMAND

echo "Container started successfully"
