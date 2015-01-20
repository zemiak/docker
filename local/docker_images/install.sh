#!/bin/sh

echo ... installing docker_images start script
cp docker_images /etc/init.d/
chmod +x /etc/init.d/docker_images
/usr/sbin/update-rc.d docker_images defaults 71 >/dev/null
service docker_images start
