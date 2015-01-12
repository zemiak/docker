#!/bin/sh

which busybox >/dev/null

if [ "$?" -eq "0" ]
then
	killall busybox
fi

killall python
exit 0

