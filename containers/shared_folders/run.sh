#!/bin/sh

VERSION=$1
if [ -z "$VERSION" ]
then
    VERSION = 1_0_0
fi

docker run -d -p 548:548 -p 2204:22 -v /mnt/timemachine-retina:/mnt/timemachine-retina -v /mnt/media:/mnt/media --name=shared_folders shared_folders:$VERSION
