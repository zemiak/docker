FROM debian:wheezy

RUN apt-get update && apt-get install -yq dialog apache2 cron php5 id3 wget git openssh-server postfix curl

# Install Postfix with Mail Relaying
ADD main.cf /etc/postfix/

# SSH server
RUN groupadd -r vasko -g 434 && useradd -u 432 -r -g vasko -d /home/vasko -s /bin/bash -c "Miroslav Vasko" vasko
RUN mkdir /home/vasko
RUN chown vasko.vasko /home/vasko
RUN echo 'root:docker' | chpasswd
RUN echo 'vasko:docker' | chpasswd
RUN mkdir /home/vasko/.ssh && chown vasko.vasko /home/vasko/.ssh && chmod 700 /home/vasko/.ssh
ADD http://127.0.0.1:8000/authorized_keys /home/vasko/.ssh/
RUN chown vasko.vasko /home/vasko/.ssh/authorized_keys && chmod 400 /home/vasko/.ssh/authorized_keys

WORKDIR /var/lib
RUN touch /var/log/cron.log
RUN git clone https://github.com/zemiak/podcasts.git
RUN mkdir -p /var/www/podcasts
RUN cp -r /var/lib/podcasts/web/* /var/www/podcasts/
RUN cp /var/lib/podcasts/cron/* /etc/cron.d/
RUN mkdir -p /mnt/media/inbox
RUN echo ServerName podcasts >>/etc/apache2/apache2.conf

ADD index.html /var/www/
ADD index.html /var/www/podcasts/

# MicroEmacs 2009, ZeroInstall
ADD emacs /usr/bin/emacs

EXPOSE 80 22

ADD start.sh /usr/local/bin/
CMD sh /usr/local/bin/start.sh
