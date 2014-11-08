FROM debian:wheezy
MAINTAINER zemiak@gmail.com

#ENV http_proxy http://squid.cp.com:3128
#ENV https_proxy http://squid.cp.com:3128

RUN apt-get update 
ENV DEBIAN_FRONTEND noninteractive
RUN ln -s -f /bin/true /usr/bin/chfn
RUN apt-get install -yqq netatalk


RUN mkdir -p /mnt/timemachine-retina
RUN mkdir -p /mnt/media

ADD netatalk /etc/default/
RUN echo '/mnt/timemachine-retina "BackupsRetina" allow:timemachine options:usedots,upriv,tm' >> /etc/netatalk/AppleVolumes.default
RUN echo '/mnt/media "Media" allow:timemachine options:usedots,upriv,tm' >> /etc/netatalk/AppleVolumes.default
RUN echo '-setuplog "default log_info /var/log/afpd.log"' >> /etc/netatalk/afpd.conf
RUN useradd timemachine -m -p yes
RUN chown timemachine /mnt/timemachine-retina
RUN chown timemachine /mnt/media
RUN touch /var/log/afpd.log

EXPOSE 548
CMD service netatalk start && bash
