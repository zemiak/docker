#!/bin/bash

# fix permissions on the log dir
mkdir -p /var/log/squid3
chmod -R 755 /var/log/squid3
touch /var/log/squid3/access.log
chown -R proxy:proxy /var/log/squid3

# fix permissions on the cache dir
mkdir -p /var/spool/squid3
chown -R proxy:proxy /var/spool/squid3

# initialize the cache_dir
if [ ! -d /var/spool/squid3/00 ]; then
  /usr/sbin/squid3 -N -f /etc/squid3/squid.conf -z
fi
