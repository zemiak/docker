#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=1_1_0
fi

docker run -d -p 8081:8080 -p 2206:22 \
    --name=nasphotos \
    -e "BIN_PATH=/usr/bin" \
    -e "PHOTO_PATH=/pictures" \
    -e "TEMP_PATH=/cache" \
    -e "WATERMARK_PATH=/opt/watermarks" \
    -e "EXTERNAL_URL=http://lenovo-server.local:8081/nasphotos/" \
    -v /mnt/media/Pictures:/pictures \
    -v /mnt/media/Pictures/cache:/cache \
    nasphotos:$VERSION
