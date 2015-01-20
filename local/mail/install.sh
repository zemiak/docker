#! /bin/sh

echo ... installing mail system
export DEBIAN_FRONTEND=noninteractive
apt-get -yq install postfix >/dev/null
cp main.cf /etc/postfix/
cp /mnt/media/docker-data/mail/sasl_password /etc/postfix/
postalias /etc/postfix/sasl_password >/dev/null

