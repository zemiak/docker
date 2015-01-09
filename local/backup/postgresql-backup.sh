#!/bin/bash

# backup directory can be a file server share that the PgAgent daemon account has access to
BACKUPDIR="/mnt/media/backup/pgsql/"
TEMPFILE="/tmp/errdb"
ERR=0
ERRDB=""
echo "">$TEMPFILE

thedate=`date +%Y%m%d%H`
themonth=`date +%Y%m`

# custom output format for pg_restore, compressed by default, also with BLOBs
docker run -t -i -v /mnt/media/backup/pgsql/:/mnt/backup/ --link=movies:movies --name backup-movies-db backup-movies-db >"$BACKUPDIR/$thedate-movies.plain"
ERR1=$?

if [ "$ERR1" != "0" ] ; then
    ERR=1
    ERRDB="movies"
fi

bzip2 "$BACKUPDIR/$thedate-movies.plain"

# erase backups from last month
lastmonth=`date -d last-month +%Y%m`
rm -f $BACKUPDIR/$lastmonth* >/dev/null 2>/dev/null

if [ "$ERR" == "0" ] ; then
    echo Done >/dev/null
    #echo "backup for $thedate done" | mail -s "postgresql/mekbuk-server backup OK" zemiak@gmail.com >/dev/null 2>/dev/null
else
    echo "">>$TEMPFILE
    echo "">>$TEMPFILE
    echo "">>$TEMPFILE
    echo "">>$TEMPFILE

    echo "pgsql backup for $thedate FAILED for $ERRDB" >>$TEMPFILE
    cat $TEMPFILE | mail -s "pgsql backup FAILED" zemiak@gmail.com >/dev/null 2>/dev/null
    rm $TEMPFILE
fi
