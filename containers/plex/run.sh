#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=1_1_0
fi

mkdir -p "/mnt/plex/data/TV Shows" /mnt/plex/data/Movies /mnt/plex/data/Music
mkdir -p "/mnt/plex/config/Library/Application Support/Plex Media Server/"
docker run -d -p 2206:22 -p 32400:32400 -p 32469:32469 -p 1900:1900/udp \
    -p 32410:32410/udp -p 32412:32412/udp -p 32413:32413/udp -p 32414:32414/udp \
    -v /mnt/media/:/mnt/media -v /mnt/plex/data/:/data -v /mnt/plex/config/:/config \
    --name=plex plex:$VERSION
