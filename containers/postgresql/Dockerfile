FROM zemiak/debian

RUN apt-get update && \
    apt-get install -yq postgresql-9.4 postgresql-client cron && \
    apt-get -q clean

ENV CONFIG_DIR /etc/postgresql/9.4/main
ENV DATA_DIR /var/lib/postgresql/9.4/main

RUN mkdir /mnt/backups && \
    echo "listen_addresses='*'" >> ${CONFIG_DIR}/postgresql.conf &&\
    echo "max_prepared_transactions=16" >> ${CONFIG_DIR}/postgresql.conf &&\
    echo "host all  all  0.0.0.0/0  trust" > ${CONFIG_DIR}/pg_hba.conf

COPY start.sh /usr/local/bin/
COPY movies.plain.gz /tmp/

COPY cron.daily/* /etc/cron.daily/
RUN chmod 755 /etc/cron.daily/*


EXPOSE 22 5432
CMD ["/bin/sh", "/usr/local/bin/start.sh"]
