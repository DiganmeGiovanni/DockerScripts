#!/bin/bash
#
# This is a helper script that you can use for:
# - Create a new node app and start it up
# - Dockerize an already existing node app and start it up
#
# Please note that in both cases the application code will be
# mounted as a volume, so every change you made to source code
# will be immediately reflected inside container.
#
# Also, the docker files will be moved inside the application
# directory, so you can then modify to match your needs or when
# the app goes to production.
#

function dockerize_app() {
    
    #
    # Ask for project root
    echo "Please enter the absolute path to your application root"
    echo "  > This should be the folder where the 'package.json' file and your"
    echo "  > project main script resides"
    read -p "Enter path: " APP_ROOT
    if [ ! -d "$APP_ROOT" ]; then
        echo "$APP_ROOT Route does not exists"
        exit 1
    fi

    #
    # Ask for project name
    echo ""
    echo "Enter a name for your project, this name will be used to build image name"
    echo "and container name"
    read -p "Project name: " APP_PROJECT

    #
    # Ask for main script to run
    echo ""
    echo "Enter the name of the script to run:"
    read -p "Script name: " SCRIPT_FILE

    #
    # Ask for version of node to use
    echo ""
    echo "Which version/tag of node docker image do you want to use for your environment?"
    echo "  Eg: 8.16.0-jessie, 10.15.3-stretch etc..."
    read -p "Enter version/tag: " DOCKER_IMAGE_TAG

    #
    # Ask for container port where app will run
    echo ""
    echo "On which container port do your apps run?"
    CONTAINER_PORT=8000
    read -p "Enter container port [8000]: " TMP_CONT_PORT
    if ! [ -z "$TMP_CONT_PORT" ]; then
        CONTAINER_PORT="$TMP_CONT_PORT"
    fi

    #
    # Ask for host port where to expose app
    echo ""
    echo "On which host port do you want to expose the app?"
    HOST_PORT=8000
    read -p "Enter port [8000]: " TMP_PORT
    if ! [ -z "$TMP_PORT" ]; then
        HOST_PORT=$TMP_PORT
    fi

    #
    # Create docker files in app root
    if [ -d "$APP_ROOT/docker" ]; then
        echo "$APP_ROOT/docker Should not exists to avoid conflicts with this script"
        echo "Aborting, no changes were made to $APP_ROOT"
        exit 1
    fi
    mkdir "$APP_ROOT/docker"
    cp "./app.docker" "$APP_ROOT/docker/app.docker"
    cp "./docker-compose.yml" "$APP_ROOT/docker/docker-compose.yml"

    #
    # Replace variables into docker files
    cd "$APP_ROOT/docker/"
    sed -i "s/PROJECT_NAME/$APP_PROJECT/g" docker-compose.yml
    sed -i "s/HOST_PORT/$HOST_PORT/g" docker-compose.yml
    sed -i "s/CONTAINER_PORT/$CONTAINER_PORT/g" docker-compose.yml
    sed -i "s/SCRIPT_FILE/$SCRIPT_FILE/g" docker-compose.yml
    
    sed -i "s/DOCKER_IMG_VERSION/$DOCKER_IMAGE_TAG/g" app.docker
    echo ""
    echo "Starting up docker container"
    docker-compose up -d

    #
    # Bye message and further instructions
    echo "Happy Coding!"
    echo "See ya!"
}

dockerize_app
