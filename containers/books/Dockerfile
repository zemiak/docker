# Based on regueiro/calibre-server, santi@regueiro.es

FROM debian:wheezy
MAINTAINER zemiak@gmail.com

RUN apt-get update && apt-get install -yq dialog calibre-bin openssh-server
RUN apt-get -yq install calibre-bin

RUN mkdir -p /var/lib/books

EXPOSE 80

# SSH server
RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd
RUN mkdir /home/vasko/.ssh && chown vasko.vasko /home/vasko/.ssh && chmod 700 /home/vasko/.ssh
ADD http://127.0.0.1:8000/authorized_keys /home/vasko/.ssh/
RUN chown vasko.vasko /home/vasko/.ssh/authorized_keys && chmod 400 /home/vasko/.ssh/authorized_keys

EXPOSE 22

ADD start.sh /usr/local/bin/
CMD sh /usr/local/bin/start.sh
