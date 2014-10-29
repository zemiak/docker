# Based on regueiro/calibre-server, santi@regueiro.es

FROM debian:wheezy
MAINTAINER zemiak@gmail.com

RUN apt-get update
RUN apt-get -y install calibre-bin
RUN apt-get clean

RUN mkdir -p /var/lib/books
ENV http_proxy ""
ADD http://127.0.0.1:8000/books/files.tar.gz /var/lib/books
WORKDIR /var/lib/books
RUN tar -xzf files.tar.gz && rm -f files.tar.gz

# exporting, so it can be backed up
VOLUMES /var/lib/books

EXPOSE 80

CMD ["/usr/bin/calibre-server", "--with-library=/var/lib/books", "--with-port=80"]
