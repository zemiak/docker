#!/bin/sh

rm -rf /data/Photos/*
rmdir /data/Photos
lns -rF /mnt/media/Pictures /data/Photos
