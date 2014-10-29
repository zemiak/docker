FROM busybox
VOLUME /var/lib/books
ENV http_proxy ""
ADD http://127.0.0.1:8000/jenkins-home/files.tar.gz /var/jenkins_home
CMD /bin/sh
