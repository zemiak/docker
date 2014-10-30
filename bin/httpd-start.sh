#!/bin/sh

which busybox >/dev/null

if [ "$?" -eq "0" ]
then
	busybox httpd -p 8000 -h /mnt/media/docker-data/
	if [ "$?" -eq "0" ]
	then
		exit 0
	fi
fi

cd /mnt/media/docker-data
python -m SimpleHTTPServer &
