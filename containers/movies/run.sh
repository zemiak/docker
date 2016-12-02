#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=4_0_0
fi

mkdir -p /mnt/media/infuse
docker run --add-host mail:192.168.2.10 --add-host database:192.168.2.10 -d -p 8080:8080 -p 2200:22 \
    --name=movies \
    -v /mnt/media:/mnt/media \
    movies:$VERSION
