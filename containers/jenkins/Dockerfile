FROM debian:wheezy

ENV JAVA_VERSION 7u65
RUN apt-get update && apt-get install -y curl openjdk-7-jdk="$JAVA_VERSION"* unzip wget
RUN apt-get update && apt-get install -y wget git curl zip && rm -rf /var/lib/apt/lists/*

ENV JENKINS_VERSION 1.565.3
RUN mkdir /usr/share/jenkins/
RUN useradd -d /home/jenkins -m -s /bin/bash jenkins

COPY init.groovy /tmp/WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy
RUN curl -L http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war \
  && cd /tmp && zip -g /usr/share/jenkins/jenkins.war WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy && rm -rf /tmp/WEB-INF

ENV JENKINS_HOME /var/lib/jenkins
RUN usermod -m -d "$JENKINS_HOME" jenkins && chown -R jenkins "$JENKINS_HOME"

ENV http_proxy ""
ADD http://127.0.0.1:8000/jenkins-home/files.tar.gz "$JENKINS_HOME"
WORKDIR "$JENKINS_HOME"
RUN tar -xzf files.tar.gz && rm -f files.tar.gz

# exporting, so it can be backed up
VOLUMES /var/lib/jenkins

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

USER jenkins

COPY jenkins.sh /usr/local/bin/jenkins.sh
CMD ["java", "$JAVA_OPTS", "-jar", "/usr/share/jenkins/jenkins.war", "$JENKINS_OPTS"]
