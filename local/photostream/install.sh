#!/bin/sh

echo ... installing photostream user

test -d /home/photostream && exit 0

mkdir /home/photostream
groupadd -r photostream -g 1007
useradd -u 1007 -r -g photostream -d /home/photostream -s /bin/bash -c "photostream uploader" photostream
chown photostream.photostream /home/photostream

# a default password
echo 'photostream:photostream0' | chpasswd

