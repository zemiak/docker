#!/bin/sh

java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS &
sleep 30s

curl -X POST -d '<jenkins><install plugin="git@2.0" /></jenkins>' --header 'Content-Type: text/xml' http://localhost:8080/pluginManager/installNecessaryPlugins
curl -X POST -H "Content-Type:application/xml" -d @/tmp/movies-config.xml "http://localhost:8080/createItem?name=movies" 
