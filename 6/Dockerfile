FROM alpine:3.7

ENV SOLR_VERSION=6.6.2 \
    SOLR=solr-6.6.2 \
    JDBC_MYSQL_VERSION=5.1.40 \
    JDBC_PSQL_VERSION=9.4.1207 \
    SOLR_HEAP_SIZE=512m

LABEL solr.version=6.6
LABEL maintainer="Florian Durano <psykoterro@gmail.com>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="meg4r0m" \
    org.label-schema.name="solr-alpine" \
    org.label-schema.description="small Solr image based on alpine" \
    org.label-schema.architecture="x86_64" \
    org.label-schema.distribution="Alpine Linux" \
    org.label-schema.distribution-version="3.7" \
    org.label-schema.vcs-url="https://github.com/psykoterro/docker-solr-alpine"

ARG DOCKER_TIMEZONE=Europe/Paris

# Configure timezone
# -----------------------------------------------------------------------------
RUN apk add --update tzdata && \
	cp /usr/share/zoneinfo/$DOCKER_TIMEZONE /etc/localtime && \
    echo $DOCKER_TIMEZONE > /etc/timezone

COPY run-solr /

RUN apk add --update-cache \
        bash \
        curl \
        openjdk8-jre && \
    cd /tmp && \
    echo "Getting solr 6.6.2" >&2 && \
    curl -sSL http://archive.apache.org/dist/lucene/solr/6.6.2/solr-6.6.2.tgz -o /tmp/solr-6.6.2.tgz && \
    curl -sSL http://archive.apache.org/dist/lucene/solr/6.6.2/solr-6.6.2.tgz.sha1 -o /tmp/solr-6.6.2.tgz.sha1 && \
    echo "Checking solr 6.6.2 checksum" >&2 && \
    sha1sum -c solr-6.6.2.tgz.sha1 && \
    mkdir -p /srv && \
    gzip -dc /tmp/solr-6.6.2.tgz | tar -C /srv -x && \
    ln -sf /srv/solr-6.6.2 /srv/solr && \
    mkdir -p /srv/solr/dist && \
    echo "Getting PSQL JDBC" >&2 && \
    curl -sSL http://jdbc.postgresql.org/download/postgresql-$JDBC_PSQL_VERSION.jar -o /srv/solr/dist/postgresql-$JDBC_PSQL_VERSION.jar && \
    echo "Getting MYSQL JDBC" >&2 && \
    curl -sSL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz -o /tmp/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz && \
    echo mysql-connector-java-$JDBC_MYSQL_VERSION/mysql-connector-java-$JDBC_MYSQL_VERSION-bin.jar > /tmp/include && \
    gzip -dc /tmp/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz | tar -x -T /tmp/include > /srv/solr/dist/mysql-connector-java-$JDBC_MYSQL_VERSION-bin.jar && \
    echo "Cleaning up.." >&2 && \
    apk del curl || true && \
    rm -rf /tmp/* /var/cache/apk/* && \
    mkdir /etc/init.d/solr && \
    mv /run-solr /etc/init.d/solr/run && \
    sed -i 's/INFO/WARN/' /srv/solr/server/resources/log4j.properties && \
    chmod +x /etc/init.d/solr/run

EXPOSE 8983

WORKDIR /srv/solr

# You need to map the index / data volume from the host.
# This should be inside /srv/solr/server/solr/CORE_NAME
# Logs go into /srv/solr/server/logs.