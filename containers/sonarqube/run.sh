#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION = 1_0_0
fi

docker run -d -p 9103:9000 -p 2208:22 -p 9900:3306 --name=sonarqube sonarqube:$VERSION
