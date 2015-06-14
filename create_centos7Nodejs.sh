#
# Created on: Sat, Jun 13, 2015
# @author Giovanni Aguirre | @DiganmeGiovanni
#
# This script users the image 'diganmegiovanni/centos7_nodejs:v1' to create and start
# a container running Centos 7, nodejs and npm.
#
# -----------------------------------------------------------------------------------
# Script execute and configure on next sequence:
# 
# 1. Prompts the user for a name for the container
# 2. Prompts the user for a 'local directory path' to autoshare to the '/sources' 
#    path on container. You'll use this path to execute nodejs sources on container.
# 3. Prompts the user for a local port to execute nodejs apps
# 4. Prompts the user for a container port to execute nodejs apps and mapping to
#    previusly indicated 'local port'.
#
# /* TODO */
# 5. Prompts to the user for a MYSQL container to link with this container
# 6. Prompts to the user for a MongoDB container to link with this container

CONTAINER_NAME="cnode"
LOCAL_DIR_TOSHARE=""
LOCAL_NODEJS_PORT=8080
CONTAINER_NODEJS_PORT=3000

# Asking for container's name
echo "Write a valid name for the new container."
read -p  "Container name[cnode]: " TMP_CONTNAME
if ! [ -z "$TMP_CONTNAME" ];
then
  CONTAINER_NAME=$TMP_CONTNAME
fi
echo "  Name for container will be: $CONTAINER_NAME"

# Asking local directory to share with container
askLocalDir ()
{
    echo
    echo "Write a valid sources local directory to share with container"
    read -p "Local directory: " LOCALDIR
    if [ -d "$LOCALDIR" ];
    then
        LOCAL_DIR_TOSHARE=$LOCALDIR
        return 1
    else
        echo "$LOCALDIR is not a valid directory, try again"
        askLocalDir
    fi
}
askLocalDir
echo "Sharing '$LOCAL_DIR_TOSHARE' at '/source' path on container"

# Local port to execute nodejs apps
echo
echo "On which local port should the container execute nodejs apps?"
read -p "Local port[8080]: " LOCAL_PORT
if ! [ -z "$LOCAL_PORT" ];
then
    LOCAL_NODEJS_PORT=$LOCAL_PORT
fi
echo " Nodejs apps will run on port: $LOCAL_NODEJS_PORT"

# Container port to execute nodejs apps
echo
echo "On which container port should the container execute nodejs apps?"
read -p "Container port[3000]: " CONTAINER_PORT
if ! [ -z "$CONTAINER_PORT" ];
then
    CONTAINER_NODEJS_PORT=$CONTAINER_PORT
fi
echo " Mapping container port [$CONTAINER_NODEJS_PORT] to local port [$LOCAL_NODEJS_PORT]"

echo
echo "Creating container with command:"
echo "docker run -t -i -p $LOCAL_NODEJS_PORT:$CONTAINER_NODEJS_PORT --name $CONTAINER_NAME -v $LOCAL_DIR_TOSHARE:/sources diganmegiovanni/centos7_nodejs:v1 /bin/bash"
echo
echo "executing command ... ..."
echo
docker run -t -i -p $LOCAL_NODEJS_PORT:$CONTAINER_NODEJS_PORT --name $CONTAINER_NAME -v $LOCAL_DIR_TOSHARE:/source diganmegiovanni/centos7_nodejs:v1 /bin/bash
