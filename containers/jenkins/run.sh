#!/bin/sh

docker run -d -p 9001:8080 -p 2202:22 --name=jenkins jenkins:1_0_0
