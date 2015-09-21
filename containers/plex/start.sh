#!/bin/sh

dpkg-reconfigure ntp
service postfix start
service ssh start
service plexmediaserver start

cd /opt/plexconnect
python ./PlexConnect.py
