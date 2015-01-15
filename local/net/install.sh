#!/bin/sh

cp interfaces /etc/network/
cp hosts /etc/
cp hostname /etc/

service networking restart
/etc/init.d/hostname.sh start

apt-get update
if [ $? -ne 0 ]
then
    echo "Networking not configured properly"
    exit 1
fi

apt-get -yq install avahi-daemon

cp avahi-hosts /etc/avahi/hosts
service avahi-daemon restart
