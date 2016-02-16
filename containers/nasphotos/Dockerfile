FROM zemiak/wildfly
MAINTAINER zemiak@gmail.com

RUN mkdir -p /pictures
USER wildfly
COPY nasphotos.war /opt/wildfly/standalone/deployments/

VOLUME ["/pictures"]
EXPOSE 8080 22
