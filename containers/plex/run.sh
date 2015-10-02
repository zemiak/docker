#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=1_0_0
fi

mkdir -p /mnt/plex/data "/mnt/plex/config/Library/Application Support/Plex Media Server/"
cp Preferences.xml "/mnt/plex/config/Library/Application Support/Plex Media Server/"
docker run -d -p 80:80 -p 443:443 -p 2206:22 -p 32400:32400 -p 53:53/udp -p 53:53 \
    -v /mnt/media/:/mnt/media -v /mnt/plex/data/:/data -v /mnt/plex/config/:/config \
    --name=plex plex:$VERSION
