#!/bin/sh

/etc/init.d/cron start
sh /usr/local/bin/start-payara.sh

tail -f /etc/hosts
