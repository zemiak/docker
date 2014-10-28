###
# based on sillenttroll/wildfly-java-8 by Alex Guzun "alex@aguzun.com"
###

FROM debian:wheezy
MAINTAINER zemiak@gmail.com

USER root

# Install JDK8 from Oracle
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get -q update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -yq install oracle-java8-installer
RUN apt-get -yq install oracle-java8-set-default

# Install git
RUN apt-get -yq install git

# Clean APT cache
RUN apt-get -q clean

# Install Maven
RUN cd /opt && wget -q http://www.us.apache.org/dist/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz
RUN cd /opt && tar -xzf apache-maven-3.2.3-bin.tar.gz && rm -f apache-maven-3.2.3-bin.tar.gz
RUN ln -s /opt/apache-maven-3.2.3 /opt/maven

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 8.1.0.Final

# Add the WildFly distribution to /opt
RUN cd /opt && wget -q http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz
RUN cd /opt && tar xzf wildfly-$WILDFLY_VERSION.tar.gz && rm wildfly-$WILDFLY_VERSION.tar.gz

# Make sure the distribution is available from a well-known place
RUN ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/wildfly

# Create the wildfly user and group
RUN groupadd -r wildfly -g 433 && useradd -u 431 -r -g wildfly -d /opt/wildfly -s /bin/false -c "WildFly user" wildfly

# Change the owner of the /opt/wildfly directory
RUN chown -R wildfly:wildfly /opt/wildfly*

# Run everything below as the wildfly user
USER wildfly

############################################################ Deploying Movies: start
# Install ffmpeg, mp4info
apt-get -yq install ffmpeg mp4v2-utils

# Clone the Movies
RUN cd /opt/wildfly && mkdir projects
RUN echo Clone 2...
RUN cd /opt/wildfly/projects && git clone https://github.com/zemiak/movies.git

# Build the Movies
WORKDIR /opt/wildfly/projects/movies
RUN chmod +x wildfly
RUN ./wildfly
RUN export PATH=$PATH:/opt/maven/bin && mvn clean package

# Setup the Wildfly to support Movies
WORKDIR /opt/wildfly
RUN /opt/wildfly/bin/add-user.sh vasko 123456 --silent
RUN echo '#!/bin/bash' >/tmp/run-wildfly.bash
RUN echo '/opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &' >>/tmp/run-wildfly.bash
RUN bash /tmp/run-wildfly.bash && sleep 10s && cd /opt/wildfly/projects/movies/setup/wildfly && bash setup.sh prod && /opt/wildfly/bin/jboss-cli.sh --connect --command="deploy /opt/wildfly/projects/movies/target/movies.war --force --runtime-name=movies"

# Kill the Wildfly
RUN killall java
############################################################ Deploying Movies: end

# Expose the ports we're interested in
EXPOSE 8080 9990

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
