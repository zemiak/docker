#!/bin/sh

cp restart-plex-at-5am /etc/cron.d/
service cron reload >/dev/null
