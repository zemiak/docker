FROM debian:wheezy

RUN apt-get -yq install apache2 cron php5 id3 wget git
WORKDIR /var/lib
RUN git clone https://github.com/zemiak/podcasts.git
RUN mkdir -p /var/www/podcasts
RUN cp -r /var/lib/podcasts/web/* /var/www/podcasts/
RUN cp /var/lib/podcasts/cron/* /etc/cron.d/
RUN mkdir -p /mnt/media/inbox

ADD index.html /var/www/
ADD index.html /var/www/podcasts/

# Install Postfix with Mail Relaying
RUN apt-get -yq install postfix
ADD main.cf /etc/postfix/

ADD start.sh /var/lib/podcasts/

EXPOSE 80

# SSH server
RUN apt-get install -yq openssh-server
RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/false -c "Miroslav Vasko" vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd

EXPOSE 22

CMD sh /var/lib/podcasts/start.sh
