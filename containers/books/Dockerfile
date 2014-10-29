# Based on regueiro/calibre-server, santi@regueiro.es

FROM debian:wheezy
MAINTAINER zemiak@gmail.com

RUN apt-get update
RUN apt-get -y install calibre-bin
RUN apt-get clean

EXPOSE 80

CMD ["/usr/bin/calibre-server", "--with-library=/var/lib/calibre", "--with-port=80"]
