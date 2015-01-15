#!/bin/sh

echo ... installing heartbeat scripts
cp at-reboot-time /etc/cron.d/
cp heartbeat-every-5-minutes /etc/cron.d/
cp online-mail-every-10-minutes /etc/cron.d/
cp heartbeat.sh /usr/local/bin/
chmod +x /usr/local/bin/heartbeat.sh
mkdir -p /var/heartbeat
service cron reload >/dev/null
