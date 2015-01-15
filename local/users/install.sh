#!/bin/sh

test -d /home/vasko && exit 0

mkdir /home/vasko
groupadd -r vasko -g 434 
useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
chown vasko.vasko /home/vasko

# a default password
echo 'vasko:vasko' | chpasswd

# a RSA key for SSH to docker images -- no password
mkdir .ssh 
chmod 700 .ssh 
ssh-keygen -f .ssh/id_rsa -t rsa -N '' >/dev/null

echo "... !!! Do not forget to change the password for vasko !!!"
