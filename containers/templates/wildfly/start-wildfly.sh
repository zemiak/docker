#!/bin/sh

export JAVA_HOME=/opt/jdk
export PATH=$PATH:/opt/jdk/bin

/usr/local/bin/start-debian.sh
/opt/wildfly/bin/add-user.sh -m -u admin -p admin
/opt/wildfly/bin/standalone.sh --debug -b 0.0.0.0 -bmanagement 0.0.0.0
