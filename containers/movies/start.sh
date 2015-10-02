#!/bin/sh

export JAVA_HOME=/opt/jdk
export PATH=$PATH:/opt/jdk/bin

dpkg-reconfigure ntp
service postgresql start
service postfix start
service ssh start
service cron start
service ntp start

# Wildfly Application Server with the movies application
/opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
