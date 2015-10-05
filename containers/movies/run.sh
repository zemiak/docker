#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=1_0_0
fi

mkdir -p /mnt/plex
docker run -d -p 8080:8080 -p 2200:22 --name=movies \
    -v /mnt/media/Movies:/mnt/media/Movies \
    -v /mnt/media/Music:/mnt/media/Music \
    -v /mnt/plex/data:/mnt/plex/data \
    -v /mnt/media/Pictures/Movies:/mnt/media/Pictures/Movies \
    -v /mnt/media/backup/pgsql:/mnt/backup \
    movies:$VERSION
