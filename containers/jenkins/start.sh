#!/bin/sh

service cron start
java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS &
