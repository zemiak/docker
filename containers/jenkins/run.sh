#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION = 1_0_0
fi

docker run -d -p 9001:8080 -p 2202:22 --name=jenkins jenkins:$VERSION
