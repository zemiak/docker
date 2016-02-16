#!/bin/sh

dpkg-reconfigure ntp
/etc/init.d/ssh start
/etc/init.d/postfix start
/etc/init.d/ntp start
