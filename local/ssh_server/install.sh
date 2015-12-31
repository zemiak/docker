#!/bin/sh

echo ... installing SSH server
apt-get -yq install openssh-server >/dev/null
cp ssh_config /etc/ssh/
