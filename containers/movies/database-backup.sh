#!/bin/bash

BACKUPDIR="/mnt/backup"
TEMPFILE="/tmp/errdb"
ERR=0
ERRDB=""
echo "">$TEMPFILE

thedate=`date +%Y%m%d%H`
themonth=`date +%Y%m`

# put the names of the databases you want to create an individual backup below
dbs=(/var/lib/movies/database)

# iterate thru dbs in dbs array and backup each one
for db in ${dbs[@]}
do
  /opt/jdk/bin/java -jar /opt/wildfly/modules/system/layers/base/com/h2database/h2/main/h2-1.3.173.jar \
    org.h2.tools.RunScript -url jdbc:h2:${db} -user sa \
    -script "$BACKUPDIR/$thedate-$db.plain" 2>>$TEMPFILE

  ERR1=$?
  bzip2 "$BACKUPDIR/$thedate-$db.plain"
  
  if [ "$ERR1" != "0" ] ; then
      ERR=1
      ERRDB="$db $ERRDB"
  fi
done

# erase backups older than 6 months
cd $BACKUPDIR
find . -mtime +60 -exec rm {} \;

if [ "$ERR" == "0" ] ; then
    echo Done >/dev/null
    #echo "backup for $thedate done" | mail -s "movies backup OK" zemiak@gmail.com >/dev/null 2>/dev/null
else
    echo "">>$TEMPFILE
    echo "">>$TEMPFILE
    echo "">>$TEMPFILE
    echo "">>$TEMPFILE

    echo "movies backup for $thedate FAILED for $ERRDB" >>$TEMPFILE
    cat $TEMPFILE | mail -s "movies backup FAILED" zemiak@gmail.com >/dev/null 2>/dev/null
    rm $TEMPFILE
fi
