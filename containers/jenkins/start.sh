#!/bin/sh

service postfix start
service cron start
service ssh start
java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS &
bash
