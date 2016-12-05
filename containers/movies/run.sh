#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=4_1_0
fi

mkdir -p /mnt/media/infuse
docker run -d \
    -e "BIN_PATH=/usr/bin" \
    -e "MEDIA_PATH=/mnt/media" \
    -e "SYSTEM_NAME=prod" \
    -e "MAIL_TO=zemiak@gmail.com" \
    -e "EXTERNAL_URL=http://lenovo-server.local:8080/movies/" \
    --add-host mail:192.168.2.10 \
    --add-host database:192.168.2.10 \
    -p 8080:8080 -p 2200:22 \
    --name=movies \
    -v /mnt/media:/mnt/media \
    movies:$VERSION
