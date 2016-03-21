FROM zemiak/debian

# Install JDK8 from Oracle (JDK8 needed because projects are JDK8 based)
RUN curl http://192.168.2.10:8000/repo/jdk.tar.gz >/opt/jdk.tar.gz && \
    cd /opt && tar -xzf /opt/jdk.tar.gz && \
    rm -f /opt/jdk.tar.gz

RUN ln -s /opt/jdk1* /opt/jdk
RUN mkdir -p /opt/java && cd /opt/java && ln -s /opt/jdk1* jdk
ENV JAVA_HOME /opt/jdk
ENV PATH $PATH:/opt/jdk/bin

