#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION = 1_0_0
fi

docker run -d -p 8080:8080 -p 2200:22  -p 53:53/udp -p 53:53 --name=movies \
    -v /mnt/media/Movies:/mnt/media/Movies \
    -v /mnt/media/Pictures/Movies:/mnt/media/Pictures/Movies \
    -v /mnt/media/backup/pgsql:/mnt/backup \
    movies:$VERSION
