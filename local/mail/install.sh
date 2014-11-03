#! /bin/sh

apt-get update
apt-get -yq install postfix
cp main.cf /etc/postfix/
