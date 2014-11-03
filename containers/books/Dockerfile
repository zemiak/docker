# Based on regueiro/calibre-server, santi@regueiro.es

FROM debian:wheezy
MAINTAINER zemiak@gmail.com

#ENV http_proxy http://squid.cp.com:3128
#ENV https_proxy http://squid.cp.com:3128

RUN apt-get update
RUN apt-get -y install calibre-bin
RUN apt-get clean

RUN mkdir -p /var/lib/books

EXPOSE 80

CMD ["/usr/bin/calibre-server", "--with-library=/var/lib/books", "--port", "80"]
