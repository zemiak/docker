#!/bin/sh

VER=8
cat /etc/debian_version | grep '^7\..*$' >/dev/null && VER=7

if [ "$VER" == "7" ]
then
    echo "deb http://get.docker.io/ubuntu docker main" >/etc/apt/sources.list.d/docker.list
    apt-get update
    apt-get -yq install lxc-docker
else
    apt-get update
    apt-get -yq install docker.io
fi

adduser vasko docker
