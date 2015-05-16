#! /bin/sh

dpkg-reconfigure ntp
service postfix start
service cron start
service apache2 start
service ssh start
service ntp start
tail -f /var/log/apache2/access.log
