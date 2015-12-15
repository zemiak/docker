#!/bin/sh

export JAVA_HOME=/opt/jdk
export PATH=$PATH:/opt/jdk/bin

dpkg-reconfigure ntp
/etc/init.d/postfix start
/etc/init.d/ssh start
/etc/init.d/ntp start

# Forked-DAAPD (iTunes Music Server)
/etc/init.d/dbus start
/etc/init.d/avahi-daemon start
/usr/sbin/forked-daapd -f -c /etc/forked-daapd.conf
/etc/init.d/avai-daemon stop
/etc/init.d/dbus stop

# Wildfly Application Server with the movies application
/opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
