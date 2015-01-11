#!/bin/sh

test -d /home/vasko && exit 0

mkdir /home/vasko
groupadd -r vasko -g 434 
useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
chown vasko.vasko /home/vasko
echo 'vasko:vasko' | chpasswd
echo "Do not forget to change the password for vasko"
