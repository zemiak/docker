#!/bin/sh

cat /etc/fstab | grep media && exit 1
cat "/dev/sdb2 /mnt/media ext4 defaults,noatime,noexec 0 0" >>/etc/fstab
cat "/dev/sdb3 /mnt/timemachine-retina ext4 defaults,noatime,noexec 0 0" >>/etc/fstab
mount /mnt/media
mount /mnt/timemachine-retina
