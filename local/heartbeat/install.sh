#!/bin/sh

echo ... installing heartbeat scripts
cp at-reboot-time /etc/cron.d/
cp heartbeat-job /etc/cron.d/
cp online-mail-job /etc/cron.d/
cp heartbeat.sh /usr/local/bin/
chmod +x /usr/local/bin/heartbeat.sh
mkdir -p /var/heartbeat
service cron reload >/dev/null
