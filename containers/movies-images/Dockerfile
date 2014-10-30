FROM debian:wheezy
MAINTAINER zemiak@gmail.com

#ENV http_proxy http://squid.cp.com:3128
#ENV https_proxy http://squid.cp.com:3128

RUN apt-get update && apt-get -yq install apache2 php5 php5-pgsql git

ENV http_proxy ""
RUN mkdir /var/www/movies/
ADD http://127.0.0.1:8000/movies-images/files.tar.gz /var/www/movies/
WORKDIR /var/www/movies
RUN tar -xzf files.tar.gz && rm -f files.tar.gz

# exporting, so it can be backed up
VOLUMES /var/www/movies

# Clone the movies project
RUN mkdir /var/projects
WORKDIR /var/projects
RUN git clone https://github.com/zemiak/movies.git
RUN cp /var/projects/movies/src/main/resources/php/* /var/www/movies/
RUN rm -rf /var/projects

EXPOSE 80
CMD service apache2 start && bash

