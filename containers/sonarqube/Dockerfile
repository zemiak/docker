FROM debian:wheezy

# Source: https://github.com/Batmat/sonarqube-mysql

# Install build dependencies
RUN apt-get update && apt-get install -yq dialog git curl postfix openssh-server openjdk-7-jdk mysql-server unzip wget

# Install Postfix with Mail Relaying
ADD main.cf /etc/postfix/

#   SonarQube
ENV sonarQubeVersion 5.1

RUN mkdir -p /opt/
WORKDIR /opt
RUN wget http://dist.sonar.codehaus.org/sonarqube-${sonarQubeVersion}.zip 
RUN unzip sonarqube-*.zip
RUN rm sonarqube-*.zip 
RUN mv sonarqube-${sonarQubeVersion} sonarqube

RUN sed -i 's/^#\?sonar.jdbc.username.*$/sonar.jdbc.username=\${env:SONAR_JDBC_USERNAME}/' /opt/sonarqube/conf/sonar.properties
RUN sed -i 's/^#\?sonar.jdbc.password.*$/sonar.jdbc.password=\${env:SONAR_JDBC_PASSWORD}/' /opt/sonarqube/conf/sonar.properties
RUN sed -i 's/^#\?sonar.jdbc.url.*$/sonar.jdbc.url=\${env:SONAR_JDBC_URL}/'                /opt/sonarqube/conf/sonar.properties

ENV SONAR_JDBC_USERNAME sonar
ENV SONAR_JDBC_PASSWORD sonar
ENV SONAR_JDBC_URL jdbc:mysql://localhost:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true

# MySQL
RUN apt-get install -y mysql-server && \
    sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf

# Init MySql
ADD init-mysql-sonarqube-db.sql mysql.ddl
RUN mysqld & sleep 10 && \
    mysql < mysql.ddl && \
    mysqladmin shutdown

ADD start.sh /usr/local/bin/start.sh

# SSH server
RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd
RUN mkdir /home/vasko/.ssh && chown vasko.vasko /home/vasko/.ssh && chmod 700 /home/vasko/.ssh
ADD http://127.0.0.1:8000/authorized_keys /home/vasko/.ssh/
RUN chown vasko.vasko /home/vasko/.ssh/authorized_keys && chmod 400 /home/vasko/.ssh/authorized_keys

EXPOSE 9000 22 3306

ADD start.sh /usr/local/bin/start.sh
CMD sh /usr/local/bin/start.sh
