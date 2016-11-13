#!/bin/sh

sh /usr/local/bin/start-debian.sh
/etc/init.d/cron start
/etc/init.d/postgresql start

if [ ! -f $DATA_DIR/CONFIGURED ]
then
    psql -h 127.0.0.1 -U postgres -w --command "CREATE DATABASE movies;"
    zcat /tmp/movies.plain.gz | psql -h 127.0.0.1 -U postgres -w movies
    rm /tmp/movies.plain.gz
    
    echo "Movies DB restored"
    touch $DATA_DIR/CONFIGURED
fi

tail -f /etc/hosts
