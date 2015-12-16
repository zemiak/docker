#!/bin/sh

/etc/init.d/postfix start
/etc/init.d/ssh start
/etc/init.d/postgresql start

/opt/sonarqube/bin/linux-x86-64/sonar.sh console &
java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS --prefix=/jenkins
