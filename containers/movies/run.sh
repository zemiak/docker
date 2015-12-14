#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=3_0_0
fi

mkdir -p "/mnt/plex/data/TV Shows" /mnt/plex/data/Movies /mnt/plex/data/Music \
    /mnt/plex/data/Photos
mkdir -p "/mnt/plex/config/Library/Application Support/Plex Media Server/"
docker run -d -p 8080:8080 -p 2200:22 -p 32400:32400 -p 32469:32469 -p 1900:1900/udp \
    -p 32410:32410/udp -p 32412:32412/udp -p 32413:32413/udp -p 32414:32414/udp \
    --name=movies \
    -v /mnt/media/Movies:/mnt/media/Movies \
    -v /mnt/media/Music:/mnt/media/Music \
    -v /mnt/media/backup/movies-database:/mnt/backup \
    -v /mnt/media/Pictures:/mnt/media/Pictures \
    -v /mnt/plex/data/:/data \
    -v /mnt/plex/config/:/config
    movies:$VERSION
