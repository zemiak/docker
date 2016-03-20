FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq dialog openssh-server psmisc postfix zip ntp curl locales && apt-get -q clean

RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd
RUN mkdir /home/vasko/.ssh && chown vasko.vasko /home/vasko/.ssh && chmod 700 /home/vasko/.ssh

# Install Postfix with Mail Relaying
COPY main.cf /etc/postfix/

# MicroEmacs 2009, ZeroInstall
COPY emacs /usr/bin/

# Central European Time
RUN cp /usr/share/zoneinfo/Europe/Bratislava /etc/localtime
RUN echo "export LC_ALL=en_US.utf8" >>/etc/profile

EXPOSE 22

COPY start-debian.sh /usr/local/bin/
CMD sh /usr/local/bin/start-debian.sh
