#!/bin/sh

echo ... installing users

test -d /home/vasko && exit 0

mkdir /home/vasko
groupadd -r vasko -g 434
useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
chown vasko.vasko /home/vasko

# a default password
echo 'vasko:docker' | chpasswd
echo 'root:docker' | chpasswd

# a RSA key for SSH to docker images -- no password
cd /home/vasko
mkdir .ssh
chown vasko.vasko .ssh
chmod 700 .ssh
su -c "ssh-keygen -f .ssh/id_rsa -t rsa -N ''" vasko >/dev/null
cp /home/vasko/.ssh/id_rsa.pub /mnt/media/docker-data/authorized_keys

echo "... !!! Do not forget to change the password for vasko !!!"
