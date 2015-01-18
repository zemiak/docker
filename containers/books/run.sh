#!/bin/sh

docker run -d -p 9101:80 -p 2201:22 --name=books -v /mnt/media/Books:/var/lib/books books:1_0_0
