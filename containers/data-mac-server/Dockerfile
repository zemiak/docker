FROM busybox
VOLUME /var/lib/vmware
ENV http_proxy ""
ADD http://127.0.0.1:8000/mac-server/files.tar.gz /var/lib/virtualbox/
CMD /bin/sh
