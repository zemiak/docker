#!/bin/sh

echo ... preparing base docker package

if [ -x /usr/bin/docker ]
then
    exit 0
fi

FOLDER="`pwd`"

cd ../../containers/templates/debian
docker build --tag=zemiak/debian .
cd ../java
docker build --tag=zemiak/java .
cd ../wildfly
docker build --tag=zemiak/wildfly .

cd "$FOLDER"