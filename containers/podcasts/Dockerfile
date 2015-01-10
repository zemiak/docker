FROM debian:wheezy

RUN apt-get update
RUN apt-get -yq install apache2 cron php5 id3 wget git
RUN apt-get install -yq openssh-server
RUN apt-get -yq install postfix

# Install Postfix with Mail Relaying
ADD main.cf /etc/postfix/

# SSH server
RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd
EXPOSE 22

ENV PODCASTS_VERSION 1_0_0
WORKDIR /var/lib
RUN git clone https://github.com/zemiak/podcasts.git
RUN cd podcasts && git checkout tags/$PODCASTS_VERSION
RUN mkdir -p /var/www/podcasts
RUN cp -r /var/lib/podcasts/web/* /var/www/podcasts/
RUN cp /var/lib/podcasts/cron/* /etc/cron.d/
RUN mkdir -p /mnt/media/inbox
RUN echo ServerName podcasts >>/etc/apache2/apache2.conf

ADD index.html /var/www/
ADD index.html /var/www/podcasts/

ADD start.sh /usr/local/bin/
EXPOSE 80

CMD sh /usr/local/bin/start.sh
