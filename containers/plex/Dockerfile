FROM debian:wheezy
MAINTAINER zemiak@gmail.com

RUN apt-get update && apt-get -yq install dialog openssh-server postfix bzip2 locales \
    ntp python

# SSH Server
RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd
RUN mkdir /home/vasko/.ssh && chown vasko.vasko /home/vasko/.ssh && chmod 700 /home/vasko/.ssh
ADD http://127.0.0.1:8000/authorized_keys /home/vasko/.ssh/
RUN chown vasko.vasko /home/vasko/.ssh/authorized_keys && chmod 400 /home/vasko/.ssh/authorized_keys

# Mail
ADD main.cf /etc/postfix/

RUN echo "export LC_ALL=en_US.utf8" >>/etc/profile

# MicroEmacs 2009, ZeroInstall
ADD emacs /usr/bin/emacs

# Central European Time
RUN cp /usr/share/zoneinfo/Europe/Bratislava /etc/localtime

# PLEX Media Server
WORKDIR /tmp
ENV PLEX_PACKAGE plexmediaserver_0.9.12.11.1406-8403350_amd64.deb
ADD http://127.0.0.1:8000/plex/${PLEX_PACKAGE} /tmp/
RUN dpkg -i ${PLEX_PACKAGE} && rm -f ${PLEX_PACKAGE}
RUN mkdir -p /mnt/media /data /config

# PLEX Connect for AppleTV
WORKDIR /opt
RUN mkdir plexconnect
ADD http://127.0.0.1:8000/plex/plexconnect.tar.gz /opt/plexconnect/
RUN cd plexconnect && tar -xzf plexconnect.tar.gz && rm -f plexconnect.tar.gz
ADD Settings.cfg /opt/plexconnect/
ADD trailers.pem /opt/plexconnect/assets/certificates/
ADD trailers.cer /opt/plexconnect/assets/certificates/

WORKDIR /
RUN rm -rf /root && ln -s /config root

EXPOSE 22 80 443 643 543/udp 32400
VOLUME ["/data", "/config", "/mnt/media"]

ADD start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*
CMD "/usr/local/bin/start.sh"
