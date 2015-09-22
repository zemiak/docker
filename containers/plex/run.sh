#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION = 1_0_0
fi

docker run -d -p 80:80 -p 443:443 -p 2206:22 -p 32400:32400 -p 53:53/udp -p 53:53 --name=plex -v /mnt/media/:/data plex:$VERSION
