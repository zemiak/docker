#!/bin/sh

echo Installing core packages...

which wget >/dev/null
if [ $? -ne 0 ]
then
    apt-get update >/dev/null
    if [ $? -ne 0 ]
    then
	echo "Network not available"
	exit 2
    fi

    apt-get -yq install wget curl >/dev/null
    if [ $? -ne 0 ]
    then
	echo "Cannot install core packages"
	exit 3
    fi
fi
