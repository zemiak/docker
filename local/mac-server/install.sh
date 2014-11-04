#!/bin.sh

test -d /var/lib/virtualbox && exit 1

echo "deb http://http.debian.net/debian/ wheezy-backports main contrib" >/etc/apt/sources.list.d/wheezy-backports
apt-get update
apt-get install -yq linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,')
apt-get -yq -t wheezy-backports install virtualbox
mkdir -p /var/lib/vritualbox
cd /var/lib/virtualbox
tar -xzf /mnt/media/docker-data/mac-server/files.tar.gz
VBoxManage registervm /var/lib/virtualbox/MacServer.vbox

cp mac-server /etc/init.d/
chmod +x /etc/init.d/mac-server
/usr/sbin/update-rc.d mac-server defaults 72
