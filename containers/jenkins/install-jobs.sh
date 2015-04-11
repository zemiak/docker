#!/bin/sh

# Run the Jenkins
java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS &
sleep 30s

# Fetch the command line tools from running Jenkins
curl --noproxy localhost http://localhost:8080/jnlpJars/jenkins-cli.jar >/usr/share/jenkins/jenkins-cli.jar

# Install the GIT plugin
http_proxy= java -jar /usr/share/jenkins/jenkins-cli.jar -s http://localhost:8080/ install-plugin /tmp/scm-api.hpi -deploy
http_proxy= java -jar /usr/share/jenkins/jenkins-cli.jar -s http://localhost:8080/ install-plugin /tmp/git-client.hpi -deploy
http_proxy= java -jar /usr/share/jenkins/jenkins-cli.jar -s http://localhost:8080/ install-plugin /tmp/git.hpi -deploy

# Create the jobs
for i in /tmp/jobs/*
do
    NAME=Â`echo "$i" | cut -d '/' -f 4 | cut -d '-' -f `
    mkdir -p /var/lib/jenkins/jobs/$NAME/workspace
    cat "$i" | java -jar /usr/share/jenkins/jenkins-cli.jar -s http://localhost:8080/ create-job $NAME
done

# Configure the Jenkins (Maven, mailing)
mv /tmp/*.xml /var/lib/jenkins
java -jar /usr/share/jenkins/jenkins-cli.jar -s http://localhost:8080/ reload-configuration


killall java
