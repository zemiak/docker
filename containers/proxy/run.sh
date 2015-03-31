#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION = 1_0_0
fi

docker run -d -p 3128:3128 -p 2205:22 --name=proxy proxy:$VERSION
