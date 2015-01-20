#!/bin/sh

echo ... configuring network

cp interfaces /etc/network/
cp hosts /etc/
cp hostname /etc/

service networking restart >/dev/null
ifup eth0
/etc/init.d/hostname.sh start >/dev/null

apt-get update
if [ $? -ne 0 ]
then
    echo "Networking not configured properly"
    exit 1
fi

apt-get -yq install avahi-daemon >/dev/null

cp avahi-hosts /etc/avahi/hosts
service avahi-daemon restart >/dev/null
