FROM debian:wheezy
MAINTAINER zemiak@gmail.com

RUN apt-get update && apt-get -yq install apache2 php5 php5-pgsql git

# Clone the movies project
RUN mkdir /var/projects
WORKDIR /var/projects
RUN git clone https://github.com/zemiak/movies.git
RUN mkdir /var/www/movies/
RUN cp /var/projects/movies/src/main/resources/php/* /var/www/movies/
RUN rm -rf /var/projects/movies/*
RUN /usr/sbin/service apache2 stop

EXPOSE 80
CMD ["service", "apache2", "start"]
