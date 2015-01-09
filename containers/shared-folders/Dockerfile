FROM debian:wheezy
MAINTAINER zemiak@gmail.com

RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN ln -s -f /bin/true /usr/bin/chfn
RUN apt-get install -yqq netatalk


RUN mkdir -p /mnt/timemachine-retina
RUN mkdir -p /mnt/media

# Password encoding: openssl passwd -1 'ClearTextPassword'

ADD netatalk /etc/default/
RUN echo '/mnt/timemachine-retina "timemachine-retina" allow:media options:usedots,upriv,tm' >> /etc/netatalk/AppleVolumes.default
RUN echo '/mnt/media "media" allow:media options:usedots,upriv,tm' >> /etc/netatalk/AppleVolumes.default
RUN echo '-setuplog "default log_info /var/log/afpd.log"' >> /etc/netatalk/afpd.conf
RUN useradd media -m -p '$1$WMvlZ8i/$Wn.sCfpkQl1TEJ033KEDr1'
RUN chown media /mnt/timemachine-retina
RUN chown media /mnt/media
RUN touch /var/log/afpd.log

EXPOSE 548


# SSH server
RUN apt-get install -yq openssh-server
RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/false -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd

EXPOSE 22

CMD service ssh start && service netatalk start && bash
