#!/bin/sh

echo ... setting up time sync
apt-get -yq install ntpdate >/dev/null

if [ $? -ne 0 ]
then
    echo "Cannot install ntpdate"
    exit 1
fi

cp ntpdate /etc/cron.hourly/
service cron restart >/dev/null
