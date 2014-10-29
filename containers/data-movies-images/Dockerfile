FROM busybox
VOLUME /var/www/movies
ENV http_proxy ""
ADD http://127.0.0.1:8000/movies-images/files.tar.gz /var/www/movies/
CMD /bin/sh
