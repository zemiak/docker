#!/bin/sh

# Database
su postgres -c "/usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf" &

# Movie Player
service apache2 start
sleep 15s

# Wildfly Application Server with the movies application
/opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &
