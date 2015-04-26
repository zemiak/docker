#!/bin/sh

service postfix start
service ssh start
service postgresql start

/opt/sonarqube/bin/linux-x86-64/sonar.sh console &
java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS --prefix=/jenkins
