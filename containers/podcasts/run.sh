#!/bin/sh

docker run -d -p 8082:80 -p 2203:22 -v /mnt/media/inbox:/mnt/media/inbox --name=podcasts podcasts:1_0_0
