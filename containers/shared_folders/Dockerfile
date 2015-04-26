FROM debian:wheezy
MAINTAINER zemiak@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq dialog samba openssh-server

RUN mkdir -p /mnt/media
ADD smb.conf /etc/samba/smb.conf
ADD start.sh /usr/local/bin/

# SSH server
RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd
RUN mkdir /home/vasko/.ssh && chown vasko.vasko /home/vasko/.ssh && chmod 700 /home/vasko/.ssh
ADD http://127.0.0.1:8000/authorized_keys /home/vasko/.ssh/
RUN chown vasko.vasko /home/vasko/.ssh/authorized_keys && chmod 400 /home/vasko/.ssh/authorized_keys

# MicroEmacs 2009, ZeroInstall
ADD emacs /usr/bin/emacs

EXPOSE 22 137 138 139 445

CMD sh /usr/local/bin/start.sh
