FROM zemiak/debian

RUN apt-get update && \
    apt-get install -yq postgresql-9.4 postgresql-client cron && \
    apt-get -q clean

COPY cron.daily/* /etc/cron/daily/
RUN chmod 640 /etc/cron.daily/*

ENV CONFIG_DIR /etc/postgresql/9.4/main
ENV DATA_DIR /var/lib/postgresql/9.4/main

RUN mkdir /mnt/backups && \
    echo "listen_addresses='*'" >> ${CONFIG_DIR}/postgresql.conf &&\
    echo "max_prepared_transactions=16" >> ${CONFIG_DIR}/postgresql.conf &&\
    echo "host all  all  0.0.0.0/0  trust" > ${CONFIG_DIR}/pg_hba.conf

COPY start.sh /usr/local/bin/
COPY movies.plain.gz /tmp/

EXPOSE 22 5432
CMD ["/bin/sh", "/usr/local/bin/start.sh"]
