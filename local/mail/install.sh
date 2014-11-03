#! /bin/sh

apt-get update
apt-get -yq install postfix
cp main.cf /etc/postfix/
cp /mnt/media/docker-data/mail/sasl_password /etc/postfix/
postalias /etc/postfix/sasl_password
