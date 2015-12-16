#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=3_1_1
fi

mkdir -p /mnt/media/infuse
docker run -d -p 8080:8080 -p 2200:22 \
    --name=movies \
    -v /mnt/media/Movies:/mnt/media/Movies \
    -v /mnt/media/Music:/mnt/media/Music \
    -v /mnt/media/backup/movies-database:/mnt/backup \
    -v /mnt/media/Pictures:/mnt/media/Pictures \
    -v /mnt/media/infuse:/mnt/media/infuse \
    -v /mnt/plex/config/:/config \
    movies:$VERSION
