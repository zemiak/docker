FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq dialog openssh-server squid3

RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd
RUN mkdir /home/vasko/.ssh && chown vasko.vasko /home/vasko/.ssh && chmod 700 /home/vasko/.ssh
ADD http://127.0.0.1:8000/authorized_keys /home/vasko/.ssh/
RUN chown vasko.vasko /home/vasko/.ssh/authorized_keys && chmod 400 /home/vasko/.ssh/authorized_keys

EXPOSE 22

# adapted from https://github.com/sameersbn/docker-squid

RUN mv /etc/squid3/squid.conf /etc/squid3/squid.conf.dist
ADD squid.conf /etc/squid3/squid.conf

ADD *.sh /usr/local/bin/
RUN sh /usr/local/bin/init.sh

EXPOSE 3128

CMD sh /usr/local/bin/start.sh
