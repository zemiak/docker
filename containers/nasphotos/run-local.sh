#!/bin/sh

docker run -d -p 8081:8080 -p 2206:22 \
    --name=nasphotos \
    -v /Volumes/media/Pictures:/pictures \
    -v /Volumes/media/Pictures/cache:/cache \
    nasphotos
