#!/bin/sh

dpkg-reconfigure ntp
service postfix start
service ssh start

cd /opt/plexconnect
python ./PlexConnect.py >>/var/log/appletv-plex-connect.log &

/usr/sbin/start_pms >>/var/log/plex-media-server.log
