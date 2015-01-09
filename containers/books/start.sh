#!/bin/sh

service ssh start
/usr/bin/calibre-server --with-library=/var/lib/books --port 80
