FROM debian:wheezy

#ENV http_proxy http://squid.cp.com:3128
#ENV https_proxy http://squid.cp.com:3128

# Install JDK8 from Oracle
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get -q update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -yq install oracle-java8-installer
RUN apt-get -yq install oracle-java8-set-default
RUN apt-get -yq install git
RUN apt-get -yq install cron
RUN apt-get -yq install curl
RUN apt-get -yq install zip

ENV JENKINS_VERSION 1.580.1
RUN mkdir /usr/share/jenkins/
RUN mkdir /usr/lib/jenkins/
RUN useradd -d /home/jenkins -m -s /bin/bash jenkins

ADD init.groovy /tmp/WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy
RUN curl -L http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war \
  && cd /tmp && zip -g /usr/share/jenkins/jenkins.war WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy && rm -rf /tmp/WEB-INF

ENV JENKINS_HOME /var/lib/jenkins
RUN usermod -m -d "$JENKINS_HOME" jenkins && chown -R jenkins "$JENKINS_HOME"
ADD jenkins-sync-repositories /etc/cron.d/
ADD movies-config.xml /tmp/movies-config.xml
ADD start.sh /usr/share/jenkins/start.sh

# clone required projects
RUN mkdir -p /var/lib/jenkins/repo
RUN rm -rf /var/lib/jenkins/repo/*
WORKDIR /var/lib/jenkins/repo
RUN git clone https://github.com/zemiak/movies.git

# install job and plugins
ADD install-jobs.sh /tmp/install-jobs.sh
RUN sh /tmp/install-jobs.sh

# for main web interface:
EXPOSE 8080

CMD /usr/share/jenkins/start.sh && bash
