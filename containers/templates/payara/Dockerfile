FROM zemiak/java
MAINTAINER zemiak@gmail.com

ENV PAYARA_ARCHIVE payara41
ENV DOMAIN_NAME domain1
ENV INSTALL_DIR /opt

RUN curl -o ${INSTALL_DIR}/${PAYARA_ARCHIVE}.zip -L http://192.168.2.10:8000/repo/payara-4.1.1.163.zip && \
    unzip -qq ${INSTALL_DIR}/${PAYARA_ARCHIVE}.zip -d /opt && \
    rm -f ${INSTALL_DIR}/${PAYARA_ARCHIVE}.zip && cd /opt/payara41/glassfish/domains && rm -rf domain1 && mv payaradomain domain1
ENV PAYARA_HOME ${INSTALL_DIR}/payara41/glassfish
ENV EXEC ${PAYARA_HOME}/bin
ENV DEPLOYMENT_DIR ${PAYARA_HOME}/domains/${DOMAIN_NAME}/autodeploy/

ENV MONITORING_LEVEL HIGH
ENV ADMIN_PASSWORD admin
WORKDIR ${PAYARA_HOME}/bin
ENV PATH ${PATH}:${PAYARA_HOME}/bin
RUN asadmin start-domain ${DOMAIN_NAME} && \
    echo "AS_ADMIN_PASSWORD=" > payarapwd && \
    echo "AS_ADMIN_NEWPASSWORD=${ADMIN_PASSWORD}" >> payarapwd  && \
    cat payarapwd  && \
    asadmin --user=admin --passwordfile=payarapwd change-admin-password && \
    echo "AS_ADMIN_PASSWORD=${ADMIN_PASSWORD}" > payarapwd && \
    asadmin --passwordfile=payarapwd enable-secure-admin && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.monitoring-enabled=true && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.connector-connection-pool=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.connector-service=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.ejb-container=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.http-service=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.jdbc-connection-pool=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.jersey=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.jpa=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.jvm=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.security=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.thread-pool=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.transaction-service=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.web-container=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd set server.monitoring-service.module-monitoring-levels.web-services-container=${MONITORING_LEVEL} && \
    asadmin --passwordfile=payarapwd enable-secure-admin && \
    asadmin --passwordfile=payarapwd stop-domain ${DOMAIN_NAME}

EXPOSE 8080 22 4848 9009

USER root
COPY start-payara.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*
CMD "/usr/local/bin/start-payara.sh"
