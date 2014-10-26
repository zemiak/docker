# Based on regueiro/calibre-server, santi@regueiro.es

FROM debian:wheezy
MAINTAINER zemiak@gmail.com

RUN apt-get update
RUN apt-get -y install calibre-bin
RUN apt-get clean

EXPOSE 9101

RUN mkdir /opt/calibre && mkdir /opt/calibre/library

VOLUME /opt/calibre/library
CMD ["/usr/bin/calibre-server", "--with-library=/opt/calibre/library", "--with-port=9101"]
