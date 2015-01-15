#!/bin/sh

echo ... installing system mount points

cat /etc/fstab | grep '/mnt/media' >/dev/null && exit 0
echo "LABEL=media /mnt/media ext4 defaults,noatime,noexec 0 0" >>/etc/fstab
echo "LABEL=timemachine-reti /mnt/timemachine-retina ext4 defaults,noatime,noexec 0 0" >>/etc/fstab
echo "LABEL=backup-media /mnt/backup-media ext4 defaults,noatime,noexec 0 0" >>/etc/fstab
echo "LABEL=backup-server /mnt/backup-server ext4 defaults,noatime,noexec 0 0" >>/etc/fstab

mkdir -p /mnt/media
mkdir -p /mnt/timemachine-retina
mkdir -p /mnt/backup-media
mkdir -p /mnt/backup-server

mount /mnt/media
mount /mnt/timemachine-retina
