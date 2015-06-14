
# ***********************************************
# Create a docker container based on image 
# 'dgio/u14.04:nodejs' and activate auto port mapping
#
# Autoshare '/home/giovanni/Documents/Sources/NodeJS' 
# to /sources on container
#
# Start the container with a '/bin/bash' console

HOST_SOURCECODE='/home/giovanni/Documents/Sources/NodeJS'
CONT_SOURCECODE='/sources'

DOCKER_IMAGE='diganmegiovanni/u14.04:nodejs'
CONTAINER_NAME='unodejs'

## Container to link (Ensure that container are running)
MYSQLDB_CONTAINER='dmysql'
NOSQLDB_CONTAINER='mongodb'

sudo docker run -t -i -p 8080:5000 --name $CONTAINER_NAME --link dmysql:mysqldb --link mongodb:mongodb -v $HOST_SOURCECODE:$CONT_SOURCECODE $DOCKER_IMAGE /bin/bash
