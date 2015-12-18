#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=2_0_0
fi

docker run -d -p 137:137 -p 138:138 -p 139:139 -p 445:445 -p 2204:22 \
    -v /mnt/media:/mnt/media \
    --name=shared_folders \
    shared_folders:$VERSION
