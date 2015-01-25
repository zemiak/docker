#!/bin/sh

docker run -d -p 3128:3128 -p 2205:22 --name=proxy proxy:1_0_0
