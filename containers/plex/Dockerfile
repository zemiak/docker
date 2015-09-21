FROM debian:8

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq install dialog openssh-server postfix bzip2 locales \
    curl ntp python unzip

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

# PLEX Media Server
WORKDIR /tmp
RUN curl https://downloads.plex.tv/plex-media-server/0.9.12.11.1406-8403350/plexmediaserver_0.9.12.11.1406-8403350_amd64.deb >plex.deb
RUN dpkg -i plex.deb && rm -f plex.deb
RUN mkdir -p /mnt/media

# PLEX Connect for AppleTV
WORKDIR /opt
ADD plexconnect.zip /opt/
RUN unzip -qq plexconnect.zip && rm -f plexconnect.zip && mv PlexConnect-master plexconnect
ADD Settings.cfg /opt/plexconnect/
ADD trailers.pem /opt/plexconnect/assets/certificates/
ADD trailers.cer /opt/plexconnect/assets/certificates/

ADD start.sh /usr/local/bin/
RYN chmod +x /usr/local/bin/*

# SSH, DNS, PLEX
EXPOSE 22 543/udp 32400

VOLUME /mnt/media

CMD /usr/local/bin/start.sh
