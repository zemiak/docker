FROM debian:wheezy
MAINTAINER zemiak@gmail.com

RUN apt-get update && apt-get -yq install dialog openssh-server postfix bzip2 locales \
   cron ffmpeg mp4v2-utils git ffmpegthumbnailer ntp

# SSH Server
RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd
RUN mkdir /home/vasko/.ssh && chown vasko.vasko /home/vasko/.ssh && chmod 700 /home/vasko/.ssh
ADD http://127.0.0.1:8000/authorized_keys /home/vasko/.ssh/
RUN chown vasko.vasko /home/vasko/.ssh/authorized_keys && chmod 400 /home/vasko/.ssh/authorized_keys

# Mail
ADD main.cf /etc/postfix/

# Database Backup
USER root
ADD database-backup /etc/cron.d/
ADD database-backup.sh /usr/local/bin/
RUN mkdir -p /mnt/backup

# Wildfly Application Server and Movies Application
ENV MOVIES_VERSION 3_0_0

USER root

# Install JDK8 from Oracle
ADD http://127.0.0.1:8000/repo/jdk.tar.gz /opt/
RUN cd /opt && tar -xzf /opt/jdk.tar.gz && rm -f /opt/jdk.tar.gz
RUN ln -s /opt/jdk1* /opt/jdk
ENV JAVA_HOME /opt/jdk
ENV PATH $PATH:/opt/jdk/bin

# Install packages needed by Movies batch jobs and build process
RUN mkdir -p /mnt/media/Movies /mnt/media/Pictures/Movies /mnt/plex/data /mnt/media/Music

# Clean APT cache
RUN apt-get -q clean

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 10.0.0.CR2

# Add the WildFly distribution to /opt
ADD http://127.0.0.1:8000/repo/wildfly-$WILDFLY_VERSION.tar.gz /opt/
RUN cd /opt \
    && tar xzf wildfly-$WILDFLY_VERSION.tar.gz \
    && rm wildfly-$WILDFLY_VERSION.tar.gz

# Make sure the distribution is available from a well-known place
RUN ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly

# Stock 8.2 options plus UTC timezone
ADD standalone.conf /opt/wildfly/bin/

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/wildfly

# Create the wildfly user and group
RUN groupadd -r wildfly -g 433 && useradd -u 431 -r -g wildfly -d /opt/wildfly -s /bin/false -c "WildFly user" wildfly

# Change the owner of the /opt/wildfly directory
RUN chown -R wildfly:wildfly /opt/wildfly*

# Restore the database
RUN mkdir -p /var/lib/movies
ADD movies.plain.bz2 /tmp
RUN bunzip2 /tmp/movies.plain.bz2
RUN /opt/jdk/bin/java \
    -cp /opt/wildfly/modules/system/layers/base/com/h2database/h2/main/h2-1.3.173.jar \
    org.h2.tools.RunScript -url jdbc:h2:/var/lib/movies/database -user sa -script /mnt/movies.plain
RUN rm /tmp/movies.plain
RUN chown -R wildfly:wildfly /var/lib/movies
RUN chown wildfly:wildfly /var/lib/movies/*

# Run everything below as the wildfly user
USER wildfly

# Copy the WAR
RUN mkdir -p /opt/wildfly/projects/
WORKDIR /opt/wildfly/projects/
RUN git clone https://github.com/zemiak/movies.git
RUN cd movies && git checkout tags/$MOVIES_VERSION
ADD movies.war /tmp/

# Setup the Wildfly to support Movies
WORKDIR /opt/wildfly
RUN /opt/wildfly/bin/add-user.sh admin admin --silent
RUN rm -rf /opt/wildfly/standalone/configuration/standalone*.xml
ADD standalone.xml /opt/wildfly/standalone/configuration

# Setup and deploy
USER root
ADD run-wildfly-for-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run-wildfly-for-setup.sh
RUN /usr/local/bin/run-wildfly-for-setup.sh \
    && sleep 15s \
    && /opt/wildfly/bin/jboss-cli.sh --connect --command="deploy /tmp/movies.war" \
    && killall java
RUN chmod -R +s *
RUN chmod -R +t *
RUN chown -R wildfly.wildfly *
RUN rm -rf /opt/wildfly/standalone/configuration/standalone_xml_history/current

RUN echo "export LC_ALL=en_US.utf8" >>/etc/profile

# MicroEmacs 2009, ZeroInstall
ADD emacs /usr/bin/emacs

# Central European Time
RUN cp /usr/share/zoneinfo/Europe/Bratislava /etc/localtime

VOLUME ["/mnt/media/Movies", "/mnt/media/Pictures/Movies", "/mnt/plex/data", "/mnt/media/Music"]
EXPOSE 8080 9990 22

ADD start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
CMD "/usr/local/bin/start.sh"
