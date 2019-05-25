#!/bin/bash
#
# This is a helper script that you can use for:
# - Create a new django app and start it up
# - Dockerize an already existing django app and start it up
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
    echo "  > This should be the folder where the 'requirements.txt' file and your"
    echo "  > project module (Directory containing manage.py) lives in"
    read -p "Enter path: " APP_ROOT
    if [ ! -d "$APP_ROOT" ]; then
        echo "$APP_ROOT Route does not exists"
        exit 1
    fi

    # 
    # Ask for main module folder
    echo ""
    echo "Which of next folders does contains the 'manage.py'?"
    current_path="$PWD"
    cd $APP_ROOT
    ls -d */
    read -p "Enter folder: " APP_PROJECT
    if [ ! -d "$APP_PROJECT" ] || [ ! -f "$APP_PROJECT/manage.py" ]; then
        echo "$APP_PROJECT Does not seems like a django project"
        echo "Project folder should have a 'manage.py' file"
        exit 1
    fi
    cd $current_path

    #
    # Ask for version of django to use
    echo ""
    echo "Which version of python do you want to use for your environment?"
    echo "  Eg: 3.6, 3.7, 3.7.3, etc..."
    read -p "Enter version number: " PYTHON_VERSION

    #
    # Ask for host port where to expose app
    echo ""
    echo "On which host port do you want to expose the app?"
    PORT=8000
    read -p "Enter port [8000]: " TMP_PORT
    if ! [ -z "$TMP_PORT" ]; then
        PORT=$TMP_PORT
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
    sed -i "s/PROJECT_PORT/$PORT/g" docker-compose.yml
    sed -i "s/PYTHON_VERSION/$PYTHON_VERSION/g" app.docker
    echo "Starting up docker container"
    docker-compose up -d

    #
    # Bye message and further instructions
    echo "Happy Coding!"
    echo "See ya!"
}

dockerize_app
