#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=2_0_0
fi

mkdir -p /mnt/media/inbox
docker run -d -p 8082:8080 -p 2203:22 --name=podcasts \
    -v /mnt/media/inbox:/mnt/media/inbox \
    podcasts:$VERSION
