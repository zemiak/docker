#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=1_0_0
fi

docker run -d -p 8081:8080 -p 2206:22 \
    --name=nasphotos \
    -v /mnt/media/Pictures:/pictures \
    -v /mnt/media/Pictures/cache:/cache \
    nasphotos:$VERSION
