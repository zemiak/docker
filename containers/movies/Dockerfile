FROM zemiak/payara
MAINTAINER zemiak@gmail.com

RUN echo deb http://www.deb-multimedia.org jessie main non-free >>/etc/apt/sources.list && \
    apt-get update && \
    apt-get install -yq --force-yes postgresql-client cron mp4v2-utils ffmpeg ffmpegthumbnailer bzip2 && \
    apt-get clean

COPY postgresql-9.4.1212.jar $PAYARA_HOME/domains/$DOMAIN_NAME/lib/

RUN asadmin start-domain ${DOMAIN_NAME} && \
    echo "AS_ADMIN_PASSWORD=${ADMIN_PASSWORD}" > payarapwd && \
    asadmin --passwordfile=payarapwd create-jdbc-connection-pool --datasourceclassname org.postgresql.xa.PGXADataSource --restype javax.sql.XADataSource --property user=postgres:serverName=database:databaseName=movies:port=5432:password=\"\" movies_pool && \
    asadmin --passwordfile=payarapwd create-jdbc-resource --connectionpoolid movies_pool movies_db && \
    asadmin --passwordfile=payarapwd create-javamail-resource --mailuser none --fromaddress noreply@nowhere.com --mailhost mail mail/movies && \
    asadmin --passwordfile=payarapwd stop-domain ${DOMAIN_NAME} && \
    mkdir -p /mnt/media

VOLUME ["/mnt/media"]

COPY movies-database-backup /etc/cron.daily/
RUN mkdir -p /mnt/media/backup/movies-database && \
	chmod 755 /etc/cron.daily/movies-database-backup
COPY start.sh /usr/local/bin/

COPY movies.war $DEPLOYMENT_DIR

CMD sh /usr/local/bin/start.sh
