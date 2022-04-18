#!/bin/bash

echo "press h clean hard consist Images"
echo ""
echo "press s clean hard consist Containers, Network, Volumes without Images"
echo ""
echo "press v View all docker params" 
echo ""
read -p "Press key? " -n 1 -r
echo ""

if [[ $REPLY =~ [HhSs]$ ]]
then
    # Delete all containers
    list=$(docker ps -a -q)
    # if [ ! -z $list]
    # then
        docker stop $list
        docker rm -f $list
    # fi

    ## Remove All Volumes
    list=$(docker volume ls -q)
    # if [ ! -z $list]
    # then
        docker volume rm $list
    # fi

    ## Remove All Network
    list=$(docker network ls -f type=custom -q)
    # if [ ! -z $list]
    # then
        docker network rm $list
    # fi

    ## Delete image by name
    if [ ! -z $1 ]
    then
        list=$(docker image ls -a -f reference=$1)
        docker image rm -f $list
    fi

    if [[ $REPLY =~ [Hh]$ ]]
    then
    
        # Delete all images
        docker rmi -f $(docker images -q)
    fi
fi

echo ""
echo "### Images List Docker"
docker image ls

echo ""
echo "### Containers List Docker"
docker container ls -a

echo ""
echo "### Networks List Docker"
docker network ls

echo ""
echo "### Volumes List Docker"
docker volume ls
