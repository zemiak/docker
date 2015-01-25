#!/bin/sh

service ssh start

echo '192.168.2.10 lenovo-server.local' >>/etc/hosts
/usr/sbin/squid3 -NYC -d 1 -f /etc/squid3/squid.conf
