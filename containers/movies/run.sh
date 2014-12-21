#!/bin/sh

# Database
service postgresql start

# Movie Player
service apache2 start

# Wildfly Application Server with the movies application
/opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &
