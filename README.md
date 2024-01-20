# Docker for python environment with tkinter

A makefile is provided to simplify the use of this docker.

##  IMPORTANT :

Before building, please **specify the path to your python project** in a `.env` file at the root of this repository.

The `.env` file must contain the following line :

`PROJECT_PATH=/path/to/your/project`

## How to build ?

Please type `make up` to build and run the docker container.

## How to stop ?

Please type `make do` to stop the docker container.

## Need more help ?

Please type `make` or `make help` to see the help.

## Do you want to stop and clean everything ?

Please type `make reset`. This will stop the docker container and remove all related images.
