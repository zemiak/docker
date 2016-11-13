#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=1_0_0
fi

docker run -d -p 5432:5432 \
    --name=postgresql \
    -v /mnt/media/postgresql/backups/:/mnt/backups \
    postgresql:$VERSION
