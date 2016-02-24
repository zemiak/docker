FROM zemiak/debian
MAINTAINER zemiak@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq samba

RUN mkdir -p /mnt/media
COPY smb.conf /etc/samba/
COPY start.sh /usr/local/bin/

# A special Infuse share
RUN mkdir -p /mnt/media/infuse
RUN groupadd -r infuse -g 634 && useradd -u 632 -r -g vasko -d /mnt/media/infuse -s /bin/bash -c "Infuse User" infuse
RUN chown infuse.infuse /mnt/media/infuse
RUN echo 'infuse:media' | chpasswd
RUN (echo media ; echo media) | smbpasswd -s -a infuse

EXPOSE 22 137 138 139 445

CMD sh /usr/local/bin/start.sh
