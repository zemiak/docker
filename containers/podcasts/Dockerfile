FROM debian:wheezy
RUN apt-get update && apt-get -yq install apache2 cron php5 id3 wget git
RUN mkdir /var/projects
WORKDIR /var/projects
RUN git clone https://github.com/zemiak/podcasts.git
RUN mkdir /var/www/podcasts
RUN cp -r /var/projects/podcasts/* /var/www/podcasts/
RUN cp /var/projects/podcasts/cron/* /etc/cron.d/
RUN service apache2 stop
RUN service cron restart

EXPOSE 80
CMD ["service", "apache2", "start"]
