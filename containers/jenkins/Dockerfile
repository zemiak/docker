FROM zemiak/java

# Install build dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq postgresql postgresql-client

RUN mkdir /usr/share/jenkins/
RUN mkdir /usr/lib/jenkins/
RUN useradd -d /home/jenkins -m -s /bin/bash jenkins

COPY init.groovy /tmp/WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy
ADD http://127.0.0.1:8000/jenkins/jenkins.war /usr/share/jenkins/
RUN cd /tmp \
    && zip -g /usr/share/jenkins/jenkins.war WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy \
    && rm -rf /tmp/WEB-INF

ENV JENKINS_HOME /var/lib/jenkins
RUN usermod -m -d "$JENKINS_HOME" jenkins && chown -R jenkins "$JENKINS_HOME"
COPY start.sh /usr/local/bin/

ADD http://127.0.0.1:8000/jenkins/sonar-runner.zip /opt/
RUN cd /opt \
    && unzip sonar-runner*.zip \
    && rm -f *.zip \
    && ln -s sonar-runner* sonar-runner
COPY sonar-runner.properties /opt/sonar-runner/conf/

# Install Maven
ENV MAVEN_VERSION 3.2.5
ADD http://127.0.0.1:8000/repo/apache-maven-$MAVEN_VERSION-bin.tar.gz /opt/
RUN cd /opt \
    && tar -xzf apache-maven-$MAVEN_VERSION-bin.tar.gz \
    && rm -f apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN ln -s /opt/apache-maven-$MAVEN_VERSION /opt/maven
ENV MAVEN_HOME /opt/maven

# install job and plugins
USER root
ADD http://127.0.0.1:8000/jenkins/git.hpi /tmp/
ADD http://127.0.0.1:8000/jenkins/git-client.hpi /tmp/
ADD http://127.0.0.1:8000/jenkins/scm-api.hpi /tmp/
ADD http://127.0.0.1:8000/jenkins/sonar.hpi /tmp/
COPY install-jobs.sh /tmp/
COPY jobs/ /tmp/jobs/
COPY config/ /tmp/
RUN ln -s /opt/maven/bin/mvn /usr/local/bin/mvn
RUN sh /tmp/install-jobs.sh
RUN mkdir -p /opt/java
RUN ln -s /usr/lib/jvm/java-8-oracle/ /opt/java/jdk

#   SonarQube
ENV sonarQubeVersion 5.1

RUN mkdir -p /opt/
WORKDIR /opt
ADD http://127.0.0.1:8000/sonarqube/sonarqube-${sonarQubeVersion}.zip /opt/
RUN unzip sonarqube-${sonarQubeVersion}.zip >/dev/null && rm -f sonarqube-${sonarQubeVersion}.zip
RUN mv sonarqube-${sonarQubeVersion} sonarqube

ENV SONAR_JDBC_USERNAME sonar
ENV SONAR_JDBC_PASSWORD sonar
ENV SONAR_JDBC_URL jdbc:postgresql://localhost:5432/sonar

RUN sed -i 's/^#\?sonar.jdbc.username.*$/sonar.jdbc.username=\${env:SONAR_JDBC_USERNAME}/' /opt/sonarqube/conf/sonar.properties
RUN sed -i 's/^#\?sonar.jdbc.password.*$/sonar.jdbc.password=\${env:SONAR_JDBC_PASSWORD}/' /opt/sonarqube/conf/sonar.properties
RUN sed -i 's/^#\?sonar.jdbc.url.*$/sonar.jdbc.url=\${env:SONAR_JDBC_URL}/'                /opt/sonarqube/conf/sonar.properties

COPY sonarqube-db-dump.sql /tmp/
COPY pg_hba.conf /etc/postgresql/9.3/main/
USER postgres
RUN /etc/init.d/postgresql start &&\
    sleep 5 &&\
    psql --command "CREATE USER sonar WITH SUPERUSER PASSWORD 'sonar';" &&\
    createdb --owner=sonar sonar &&\
    cat /tmp/sonarqube-db-dump.sql | psql sonar >/dev/null &&\
    /etc/init.d/postgresql stop

EXPOSE 22 8080 9000

CMD sh /usr/local/bin/start.sh
