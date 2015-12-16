#!/bin/sh

chown nobody:staff /mnt/media
chown -R nobody:staff /mnt/media/
chmod g+w /mnt/media
chmod -R g+w /mnt/media/

/etc/init.d/ssh start
/etc/init.d/samba start
/etc/init.d/xinetd start

tail -f /var/log/samba/log.smbd
