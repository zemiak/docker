FROM zemiak/debian
MAINTAINER zemiak@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq calibre-bin && apt-get clean

RUN mkdir -p /var/lib/books

EXPOSE 22 80

COPY start.sh /usr/local/bin/
CMD sh /usr/local/bin/start.sh
