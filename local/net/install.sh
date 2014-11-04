#!/bin/sh

apt-get update
apt-get -yq install avahi-daemon

cp interfaces /etc/network/
cp hosts /etc/
cp hostname /etc/

service networking restart
/etc/init.d/hostname.sh start

cp avahi-hosts /etc/avahi/hosts
service avahi-daemon restart
