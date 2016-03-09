FROM zemiak/wildfly
MAINTAINER zemiak@gmail.com

RUN apt-get update && apt-get -yq --force-yes install ffmpeg mp4v2-utils ffmpegthumbnailer

RUN mkdir -p /pictures
RUN mkdir -p /cache

RUN rm -rf /opt/wildfly/standalone/configuration/standalone*.xml
ADD standalone.xml /opt/wildfly/standalone/configuration/

USER wildfly
COPY nasphotos.war /opt/wildfly/standalone/deployments/

VOLUME ["/pictures", "/cache"]
EXPOSE 8080 22
