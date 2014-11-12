FROM debian:wheezy

ENV http_proxy http://squid.cp.com:3128
ENV https_proxy https://squid.cp.com:3128

RUN apt-get update && apt-get -yq install apache2 cron php5 id3 wget git
WORKDIR /var/lib
RUN git clone https://github.com/zemiak/podcasts.git
RUN mkdir -p /var/www/podcasts
RUN cp -r /var/lib/podcasts/web/* /var/www/podcasts/
RUN cp /var/lib/podcasts/cron/* /etc/cron.d/
RUN mkdir -p /mnt/media/inbox

ADD index.html /var/www/
ADD index.html /var/www/podcasts/

EXPOSE 80
CMD service cron start && service apache2 start && bash
