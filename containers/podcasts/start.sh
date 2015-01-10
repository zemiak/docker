#! /bin/sh

service postfix start
service cron start
service apache2 start
service ssh start
tail -f /var/log/apache2/access.log
