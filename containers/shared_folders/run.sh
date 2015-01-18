#!/bin/sh

docker run -d -p 548:548 -p 2204:22 -v /mnt/timemachine-retina:/mnt/timemachine-retina -v /mnt/media:/mnt/media --name=shared_folders shared_folders:1_0_0
