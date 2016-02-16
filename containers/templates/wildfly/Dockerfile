FROM zemiak/java
MAINTAINER zemiak@gmail.com

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 10.0.0.Final

# Add the WildFly distribution to /opt
ADD http://127.0.0.1:8000/repo/wildfly-$WILDFLY_VERSION.tar.gz /opt/
RUN cd /opt \
    && tar xzf wildfly-$WILDFLY_VERSION.tar.gz \
    && rm wildfly-$WILDFLY_VERSION.tar.gz

# Make sure the distribution is available from a well-known place
RUN ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly

# UTC timezone
ADD standalone.conf /opt/wildfly/bin/

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/wildfly

# Create the wildfly user and group
RUN groupadd -r wildfly -g 433 && useradd -u 431 -r -g wildfly -d /opt/wildfly -s /bin/false -c "WildFly user" wildfly

# Change the owner of the /opt/wildfly directory
RUN chown -R wildfly:wildfly /opt/wildfly*

# Add Wildfly admin user
WORKDIR /opt/wildfly
RUN /opt/wildfly/bin/add-user.sh admin admin --silent

# Basic monitoring tool
COPY ping.war /opt/wildfly/standalone/deployments/

EXPOSE 8080 22

ADD start-wildfly.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*
CMD "/usr/local/bin/start-wildfly.sh"
