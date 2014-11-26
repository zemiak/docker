FROM debian:wheezy

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r postgres && useradd -r -g postgres postgres

#ENV http_proxy http://squid.cp.com:3128
#ENV https_proxy http://squid.cp.com:3128

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

#RUN apt-key adv --keyserver pgp.mit.edu --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

ENV PG_MAJOR 9.3
ENV PG_VERSION 9.3.5-1.pgdg70+1

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && apt-get install -y --force-yes postgresql-client-9.3

RUN mkdir /mnt/backup
VOLUME /mnt/backup

CMD pg_dump --dbname=movies --host=movies-db --blobs --username=movies_user --no-password --data-only --format=p --inserts --file=/mnt/backup/movies.plain
