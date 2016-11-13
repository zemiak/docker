#!/bin/sh

echo ... preparing base docker images

which docker || exit 1

FOLDER="`pwd`"

cd debian
docker build --tag=zemiak/debian . || exit 1
cd ../java
docker build --tag=zemiak/java . || exit 2
cd ../wildfly
docker build --tag=zemiak/wildfly . || exit 3
cd ../payara
docker build --tag=zemiak/payara . || exit 4

cd "$FOLDER"
