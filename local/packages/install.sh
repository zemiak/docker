#!/bin/sh

echo ... installing base packages
apt-get -yq install emacs23 mc less >/dev/null

if [ $? -ne 0 ]
then
    echo "Cannot install base packages"
    exit 1
fi

echo 'export EDITOR=emacs' >>/etc/bash.bashrc
