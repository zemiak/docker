#!/bin/sh

cp postgresql-backup-weekly /etc/cron.d/

cp postgresql-backup.sh /usr/local/bin/
chmod +x /usr/local/bin/postgresql-backup.sh

cp backup.bash /usr/local/bin/
chmod +x /usr/local/bin/backup.bash

service cron restart
