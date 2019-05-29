Docker Scripts
==============
Helper and utility scripts for my daily development workflow with
docker containers.<br/>
*This is my swiss knife for docker development*

## Development environments
The `DevEnvironments` directory contains scripts to dockerize
an already existant application or create a new one.

The generated docker files are very opinionated, however the
docker files are copied to each application folder so you can
edit it to match your custom needs.

Supported platforms:
- Nodejs
- Django
- Laravel

## Databases
The `Databases` directory contains scripts to start/create database
servers and expose it through your host.

Supported databases:
- MySQL
- PostgreSQL
- MongoDB

## Executables
The `executables` directory contains scripts that I usually add to
my aliases and use it to run apps like if it were installed on my
system but behind the scenes it are running on docker

Currently i can run:
- node
- npm
- composer
- mysql as client to connect to local or remote databases

