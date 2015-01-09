#!/bin/sh

export JAVA_HOME=/opt/jdk
export PATH=$PATH:/opt/jdk/bin

# Database
service postgresql start

# Movie Player
service apache2 start

# Mail sending
service postfix start

# SSH server
service ssh start

# Wildfly Application Server with the movies application
/opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
