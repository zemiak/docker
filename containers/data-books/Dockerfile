FROM busybox
VOLUME /var/lib/books
ENV http_proxy ""
ADD http://127.0.0.1:8000/books/files.tar.gz /var/lib/calibre
CMD /bin/sh
