#!/bin/sh

. /etc/docker-images/docker-images.conf

for i in $IMAGES
do
    docker start $i || exit 1
done
