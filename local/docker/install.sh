#!/bin/sh

echo "deb http://get.docker.io/ubuntu docker main" >/etc/apt/sources.list.d/docker.list
apt-get update
apt-get -yq install lxc-docker
adduser vasko docker
