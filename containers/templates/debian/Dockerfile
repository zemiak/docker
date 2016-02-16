FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq dialog openssh-server psmisc postfix zip ntp curl locales && apt-get -q clean

RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd
RUN mkdir /home/vasko/.ssh && chown vasko.vasko /home/vasko/.ssh && chmod 700 /home/vasko/.ssh
ADD http://127.0.0.1:8000/authorized_keys /home/vasko/.ssh/
RUN chown vasko.vasko /home/vasko/.ssh/authorized_keys && chmod 400 /home/vasko/.ssh/authorized_keys

# Install Postfix with Mail Relaying
ADD main.cf /etc/postfix/

# MicroEmacs 2009, ZeroInstall
ADD emacs /usr/bin/emacs

# Central European Time
RUN cp /usr/share/zoneinfo/Europe/Bratislava /etc/localtime
RUN echo "export LC_ALL=en_US.utf8" >>/etc/profile

EXPOSE 22

CMD sh /usr/local/bin/start-debian.sh