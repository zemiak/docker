FROM zemiak/debian

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq squid3 && apt-get clean

RUN mv /etc/squid3/squid.conf /etc/squid3/squid.conf.dist
COPY squid.conf /etc/squid3/

COPY *.sh /usr/local/bin/
RUN sh /usr/local/bin/init.sh

EXPOSE 3128 22

CMD sh /usr/local/bin/start.sh
