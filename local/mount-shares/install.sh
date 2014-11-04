#!/bin/sh

cat /etc/fstab | grep media && exit 1
cat "/dev/sdb2 /mnt/media  ext4    defaults,noatime" >>/etc/fstab
cat "/dev/sdb3 /mnt/timemachine-retina  ext4    defaults,noatime" >>/etc/fstab
mount /mnt/media
