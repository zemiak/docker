#!/bin/sh

chown nobody:staff /mnt/media
chown -R nobody:staff /mnt/media/
chmod g+w /mnt/media
chmod -R g+w /mnt/media/

service ssh start
service samba start

tail -f /var/log/samba/log.smbd
