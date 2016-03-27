FROM zemiak/wildfly
MAINTAINER zemiak@gmail.com

RUN echo deb http://www.deb-multimedia.org jessie main non-free >>/etc/apt/sources.list
RUN apt-get update && apt-get -yq --force-yes install ffmpegthumbnailer mediainfo

RUN mkdir -p /pictures
RUN mkdir -p /cache

RUN rm -rf /opt/wildfly/standalone/configuration/standalone*.xml
COPY standalone.xml /opt/wildfly/standalone/configuration/

USER wildfly
COPY nasphotos.war /opt/wildfly/standalone/deployments/

VOLUME ["/pictures", "/cache"]
EXPOSE 8080 22

USER root
