#!/bin/sh

echo ... installing base packages
apt-get -yq install emacs23 mc less ntp >/dev/null

if [ $? -ne 0 ]
then
    echo "Cannot install base packages"
    exit 1
fi

dpkg-reconfigure ntp >/dev/null
echo 'export EDITOR=emacs' >>/etc/bash.bashrc
