FROM zemiak/wildfly
MAINTAINER zemiak@gmail.com

RUN mkdir -p /pictures
RUN mkdir -p /cache
USER wildfly
COPY nasphotos.war /opt/wildfly/standalone/deployments/

VOLUME ["/pictures", "/cache"]
EXPOSE 8080 22
