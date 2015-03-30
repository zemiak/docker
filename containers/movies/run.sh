#!/bin/sh

docker run -d -p 8080:8080 -p 2200:22 --name=movies -v /mnt/media/Movies:/mnt/media/Movies -v /mnt/media/Pictures/Movies:/mnt/media/Pictures/Movies -v /mnt/media/backup/pgsql:/mnt/backup movies:2_0_0
