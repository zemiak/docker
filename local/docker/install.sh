#!/bin/sh

echo ... installing docker package

VER=8
cat /etc/debian_version | grep '^7\..*$' >/dev/null
if [ $? -eq 0 ]
then
    VER=7
fi

if [ $VER -eq 7 ]
then
    echo "deb http://get.docker.io/ubuntu docker main" >/etc/apt/sources.list.d/docker.list
    apt-get update >/dev/null
    apt-get -yq --force-yes install lxc-docker >/dev/null
else
    apt-get update >/dev/null
    apt-get -yq install docker.io >/dev/null
fi

if [ $? -ne 0 ]
then
    echo "Cannot install docker package"
    exit 1
fi

adduser vasko docker >/dev/null

echo 'DOCKER_OPTS="-H tcp://0.0.0.0:5555 -H unix:///var/run/docker.sock"' >>/etc/default/docke
service docker stop >/dev/null
sleep 2
service docker start >/dev/null

if [ $? -ne 0 ]
then
    echo "Cannot start docker"
    exit 2
fi
