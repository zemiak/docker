#!/bin/sh

service postfix start
service ssh start
service mysql start

/opt/sonarqube/bin/linux-x86-64/sonar.sh console
