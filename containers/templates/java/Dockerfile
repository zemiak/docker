FROM zemiak/debian

# Install JDK8 from Oracle (JDK8 needed because projects are JDK8 based)
ADD http://127.0.0.1:8000/repo/jdk.tar.gz /opt/
RUN cd /opt && tar -xzf /opt/jdk.tar.gz && rm -f /opt/jdk.tar.gz
RUN ln -s /opt/jdk1* /opt/jdk
RUN mkdir /opt/java && cd /opt/java && ln -s /opt/jdk1* jdk
ENV JAVA_HOME /opt/jdk
ENV PATH $PATH:/opt/jdk/bin

