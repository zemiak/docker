#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION=2_1_0
fi

mkdir -p /mnt/media/inbox
docker run -d \
    -p 8082:8080 -p 2203:22 -p 9009:9009 --name=podcasts \
    --add-host mail:192.168.2.10 \
    -x "MEDIA_PATH=/mnt/media/inbox" \
    -x "MAIL_TO=zemiak@gmail.com" \
    -x "RADIO_FM_URL=http://live.slovakradio.sk:8000/FM_128.mp3" \
    -v /mnt/media/inbox:/mnt/media/inbox \
    podcasts:$VERSION
