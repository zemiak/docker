#!/bin/sh

cat /etc/fstab | grep media && exit 1
cat "LABEL=media /mnt/media ext4 defaults,noatime,noexec 0 0" >>/etc/fstab
cat "LABEL=timemachine-retina /mnt/timemachine-retina ext4 defaults,noatime,noexec 0 0" >>/etc/fstab
cat "LABEL=docker-data /mnt/docker-data ext4 defaults,noatime,noexec 0 0" >>/etc/fstab
cat "LABEL=backup-media /mnt/backup-media ext4 defaults,noatime,noexec 0 0" >>/etc/fstab
cat "LABEL=backup-server /mnt/backup-server ext4 defaults,noatime,noexec 0 0" >>/etc/fstab

mkdir /mnt/media
mkdir /mnt/timemachine-retina
mkdir /mnt/docker-data
mkdir /mnt/backup-media
mkdir /mnt/backup-server

mount /mnt/media
mount /mnt/timemachine-retina
