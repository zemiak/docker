# Based on regueiro/calibre-server, santi@regueiro.es

FROM debian:wheezy
MAINTAINER zemiak@gmail.com

RUN apt-get update
RUN apt-get -yq install calibre-bin

RUN mkdir -p /var/lib/books

EXPOSE 80

# SSH server
RUN apt-get install -yq openssh-server
RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd

EXPOSE 22

ADD start.sh /usr/local/bin/
CMD sh /usr/local/bin/start.sh
