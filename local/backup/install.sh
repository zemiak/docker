#!/bin/sh

echo ... installing media backup system
cp backup-media /usr/local/bin/
chmod +x /usr/local/bin/backup-media
test -f /usr/local/bin/backup-server || ln -s /usr/local/bin/backup-media /usr/local/bin/backup-server
