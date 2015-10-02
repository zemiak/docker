#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=1_0_0
fi

docker run -d -p 8082:80 -p 2203:22 -v /mnt/media/inbox:/mnt/media/inbox --name=podcasts podcasts:$VERSION
