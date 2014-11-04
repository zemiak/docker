#!/bin/sh

cp docker-images-zemiak /etc/init.d/
chmod +x /etc/init.d/docker-images-zemiak
/usr/sbin/update-rc.d docker-images-zemiak defaults 71
