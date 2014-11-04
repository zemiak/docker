FROM debian:wheezy
MAINTAINER zemiak@gmail.com

#ENV http_proxy http://squid.cp.com:3128
#ENV https_proxy http://squid.cp.com:3128

RUN apt-get update
RUN apt-get -yq install netatalk
RUN update-rc.d netatalk defaults

mkdir -p /var/lib/time-machine
ADD afp.conf /etc/afp.conf

EXPOSE 548
CMD service netatalk start && bash
