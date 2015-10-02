#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=1_0_0
fi

docker run -d -p 9101:80 -p 2201:22 --name=books -v /mnt/media/Books:/var/lib/books books:$VERSION
