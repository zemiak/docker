#!/bin/bash

function backup_media {
  if [ ! -d /mnt/media/Movies ]
  then
    echo "Nothing to backup, source media endpoint empty" | mail -s "Backup Error" zemiak@gmail.com
    umount /mnt/backup-media
    echo "Nothing to backup, source media endpoint empty"
    exit 0
  fi

  echo "Going to backup media..."
  rsync -avh --exclude='.*' /mnt/media/ /mnt/backup-media/ | tee /tmp/rsync.txt
  cat /tmp/rsync.txt | mail -s "Backup Media Output" zemiak@gmail.com

  umount /mnt/backup-media
  echo "Done."
}

function backup_server {
  echo "Going to backup server itself..."
  echo "Server Backup:" >/tmp/rsync.txt
  
  VBoxManage controlvm MacServer pause >>/tmp/rsync.txt 2>&1
  test -d /mnt/backup-server/etc || mkdir /mnt/backup-server/etc
  test -d /mnt/backup-server/home || mkdir /mnt/backup-server/home
  test -d /mnt/backup-server/var || mkdir /mnt/backup-server/var
  test -d /mnt/backup-server/root || mkdir /mnt/backup-server/root
  
  rsync -avh --delete /etc/ /mnt/backup-server/etc/ >>/tmp/rsync.txt 2>&1
  rsync -avh --delete /home/ /mnt/backup-server/home/ >>/tmp/rsync.txt 2>&1
  rsync -avh --delete /var/ /mnt/backup-server/var/ >>/tmp/rsync.txt 2>&1
  rsync -avh --delete /root/ /mnt/backup-server/root/ >>/tmp/rsync.txt 2>&1
  
  dpkg --list >/mnt/backup-server/packages.txt
  VBoxManage controlvm MacServer resume >>/tmp/rsync.txt 2>&1
  
  cat /tmp/rsync.txt | mail -s "Backup Server Output" zemiak@gmail.com

  umount /mnt/backup-server
  echo "Done."
}

# In case they are not mounted
mount /mnt/backup-media >/dev/null 2>&1 && (backup_media ; exit 0)
mount /mnt/backup-server >/dev/null 2>&1 && (backup_server ; exit 0)

test -d /mnt/backup-media/Movies && (backup_media ; exit 0)
test -d /mnt/backup-server/etc && (backup_server ; exit 0)
