#!/bin/sh

export JAVA_HOME=/opt/jdk
export PATH=$PATH:/opt/jdk/bin

dpkg-reconfigure ntp
/etc/init.d/postfix start
/etc/init.d/ssh start
/etc/init.d/ntp start

# Wildfly Application Server with the application
/opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
