FROM debian:wheezy

# Install build dependencies
RUN apt-get update && apt-get install -yq dialog git cron curl zip postfix openssh-server

# Install JDK8 from Oracle (JDK8 needed because projects are JDK8 based)
ADD http://127.0.0.1:8000/repo/jdk-8u25-linux-x64.tar.gz /opt/
RUN cd /opt && tar -xzf /opt/jdk-8u25-linux-x64.tar.gz && rm -f /opt/jdk-8u25-linux-x64.tar.gz
RUN ln -s /opt/jdk1.8.0_25 /opt/jdk
RUN mkdir /opt/java && cd /opt/java && ln -s /opt/jdk1.8.0_25 jdk
ENV JAVA_HOME /opt/jdk
ENV PATH $PATH:/opt/jdk/bin

# Install Postfix with Mail Relaying
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
RUN mkdir /tmp/jobs
ADD ./jobs/* /tmp/jobs/
ADD start.sh /usr/local/bin/start.sh

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
RUN chown jenkins:jenkins /var/lib/jenkins
RUN chown -R jenkins:jenkins /var/lib/jenkins/*
WORKDIR /var/lib/jenkins/repo
USER jenkins
RUN git clone https://github.com/zemiak/movies.git
RUN git clone https://github.com/zemiak/online.git
RUN chown -R jenkins.jenkins movies/*
RUN chown -R jenkins.jenkins online/*
RUN mkdir -p /var/lib/jenkins/jobs/movies/workspace
RUN mkdir -p /var/lib/jenkins/jobs/online/workspace
RUN cp -r movies/* /var/lib/jenkins/jobs/movies/workspace/
RUN cp -r online/* /var/lib/jenkins/jobs/online/workspace/

# install job and plugins
USER root
ADD http://127.0.0.1:8000/jenkins/git.hpi /tmp/
ADD http://127.0.0.1:8000/jenkins/git-client.hpi /tmp/
ADD http://127.0.0.1:8000/jenkins/scm-api.hpi /tmp/
ADD install-jobs.sh /tmp/install-jobs.sh
ADD config/*.xml /tmp/
RUN ln -s /opt/maven/bin/mvn /usr/local/bin/mvn
RUN sh /tmp/install-jobs.sh
RUN mkdir -p /opt/java
RUN ln -s /usr/lib/jvm/java-8-oracle/ /opt/java/jdk

# for main web interface:
EXPOSE 8080

# SSH server
RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd
RUN mkdir /home/vasko/.ssh && chown vasko.vasko /home/vasko/.ssh && chmod 700 /home/vasko/.ssh
ADD http://127.0.0.1:8000/authorized_keys /home/vasko/.ssh/
RUN chown vasko.vasko /home/vasko/.ssh/authorized_keys && chmod 400 /home/vasko/.ssh/authorized_keys

EXPOSE 22

CMD sh /usr/local/bin/start.sh
