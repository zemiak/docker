#!/bin/sh

sh /usr/local/bin/start-debian.sh
/etc/init.d/cron start
/etc/init.d/postgresql start

if [ ! -f $DATA_DIR/CONFIGURED ]
then
    psql -h 127.0.0.1 -U postgres -w --command "CREATE DATABASE movies WITH ENCODING 'UTF8' TEMPLATE template0 OWNER postgres;" || exit 1
    zcat /tmp/movies.plain.gz | psql -h 127.0.0.1 -U postgres -w movies || exit 2
    rm /tmp/movies.plain.gz || exit 3
    
    echo "Movies DB restored"
    touch $DATA_DIR/CONFIGURED
fi

tail -f /etc/hosts
