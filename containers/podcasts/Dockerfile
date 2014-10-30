FROM debian:wheezy

#ENV http_proxy http://squid.cp.com:3128
#ENV https_proxy https://squid.cp.com:3128

RUN apt-get update && apt-get -yq install apache2 cron php5 id3 wget git
RUN mkdir /var/projects
WORKDIR /var/projects
RUN git clone https://github.com/zemiak/podcasts.git
RUN mkdir /var/www/podcasts
RUN cp -r /var/projects/podcasts/* /var/www/podcasts/
RUN cp /var/projects/podcasts/cron/* /etc/cron.d/
RUN rm -rf /var/projects
RUN mkdir -p /var/lib/podcasts

EXPOSE 80
CMD service cron start && service apache2 start && bash
