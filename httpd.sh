#!/bin/sh

cd /mnt/media/docker-data/
which busybox >/dev/null || exit 1
busybox httpd -p 8000 -h /mnt/media/docker-data/
