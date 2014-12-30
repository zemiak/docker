FROM debian:wheezy

# Install JDK8 from Oracle
ADD http://127.0.0.1:8000/repo/jdk-8u25-linux-x64.tar.gz /opt/
RUN tar -xzf /opt/jdk-8u25-linux-x64.tar.gz && rm -f /opt/jdk-8u25-linux-x64.tar.gz
RUN ln -s /opt/jdk1.8.0_25 /opt/jdk
ENV JAVA_HOME /opt/jdk
ENV PATH $PATH:/opt/jdk/bin

# Install build dependencies
RUN apt-get -q update
RUN apt-get -yq install git cron curl zip

# Install Postfix with Mail Relaying
RUN apt-get -yq install postfix
ADD main.cf /etc/postfix/

RUN mkdir /usr/share/jenkins/
RUN mkdir /usr/lib/jenkins/
RUN useradd -d /home/jenkins -m -s /bin/bash jenkins

ADD init.groovy /tmp/WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy
ADD http://127.0.0.1:8000/jenkins/jenkins.war /usr/share/jenkins/
RUN cd /tmp \
    && zip -g /usr/share/jenkins/jenkins.war WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy \
    && rm -rf /tmp/WEB-INF

ENV JENKINS_HOME /var/lib/jenkins
RUN usermod -m -d "$JENKINS_HOME" jenkins && chown -R jenkins "$JENKINS_HOME"
ADD jenkins-sync-repositories /etc/cron.d/
ADD movies-config.xml /tmp/movies-config.xml
ADD start.sh /usr/share/jenkins/start.sh

# Install Maven
ENV MAVEN_VERSION 3.2.5
ADD http://127.0.0.1:8000/repo/apache-maven-$MAVEN_VERSION-bin.tar.gz /opt/
RUN cd /opt \
    && tar -xzf apache-maven-$MAVEN_VERSION-bin.tar.gz \
    && rm -f apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN ln -s /opt/apache-maven-$MAVEN_VERSION /opt/maven
ENV MAVEN_HOME /opt/maven

# clone required projects
RUN mkdir -p /var/lib/jenkins/repo
RUN rm -rf /var/lib/jenkins/repo/*
WORKDIR /var/lib/jenkins/repo
RUN git clone https://github.com/zemiak/movies.git
RUN mkdir -p /var/lib/jenkins/jobs/movies/workspace
RUN cp -r movies/* /var/lib/jenkins/jobs/movies/workspace/

# install job and plugins
ADD http://updates.jenkins-ci.org/download/plugins/git/2.2.7/git.hpi /tmp/
ADD http://updates.jenkins-ci.org/download/plugins/git-client/1.11.1/git-client.hpi /tmp/
ADD http://updates.jenkins-ci.org/download/plugins/scm-api/0.2/scm-api.hpi /tmp/
ADD install-jobs.sh /tmp/install-jobs.sh
ADD config/*.xml /tmp/
RUN ln -s /opt/maven/bin/mvn /usr/local/bin/mvn
RUN sh /tmp/install-jobs.sh
RUN mkdir -p /opt/java
RUN ln -s /usr/lib/jvm/java-8-oracle/ /opt/java/jdk

# for main web interface:
EXPOSE 8080

CMD sh /usr/share/jenkins/start.sh && bash
