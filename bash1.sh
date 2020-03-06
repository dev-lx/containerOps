#!/bin/bash
DOCKER_REGISTRY="alwaysavail"
IMAGE_FILE="docker_images"
DATE=`(date +"%d_%m_%Y")`
IMAGE_DIR="/tmp"
while read line
do
    LOCAL_IMAGE="$(docker images|grep -i $DOCKER_REGISTRY/$line|awk '{print $1}')"
    #echo $LOCAL_IMAGE
    if [ "$LOCAL_IMAGE" != "$DOCKER_REGISTRY/$line" ]
    then
         echo $LOCAL_IMAGE
         docker pull $DOCKER_REGISTRY/$line
         docker save $DOCKER_REGISTRY/$line -o $line-$DATE.tar.gz
	 mv $line-$DATE.tar.gz $IMAGE_DIR
         #docker rmi "$LOCAL_IMAGE"
    else
	    echo -e "$DOCKER_REGISTRY/$line \tImage exist"
    fi
done < $IMAGE_FILE
##!/bin/bash
#IMAGE=`docker images|grep -i git|awk '{print $1}'`
#echo $IMAGE

