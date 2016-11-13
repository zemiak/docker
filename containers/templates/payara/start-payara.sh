#!/bin/sh

export JAVA_HOME=/opt/jdk
export PATH=$PATH:/opt/jdk/bin

sh /usr/local/bin/start-debian.sh
/opt/payara41/bin/asadmin start-domain --debug ${DOMAIN_NAME}
