FROM alpine:3.7

LABEL solr.version=4.10
LABEL maintainer="Florian Durano <psykoterro@gmail.com>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="meg4r0m" \
    org.label-schema.name="solr-alpine" \
    org.label-schema.description="small Solr image based on alpine" \
    org.label-schema.vcs-url="https://github.com/psykoterro/docker-solr-alpine"

ENV SOLR_VERSION=4.10.4 \
    SOLR=solr-4.10.4 \
    JDBC_MYSQL_VERSION=5.1.38 \
    JDBC_PSQL_VERSION=9.4.1207 \
    SOLR_HEAP_SIZE=512m

ARG DOCKER_TIMEZONE=Europe/Paris

# Configure timezone
# -----------------------------------------------------------------------------
RUN apk add --update tzdata && \
	cp /usr/share/zoneinfo/$DOCKER_TIMEZONE /etc/localtime && \
    echo $DOCKER_TIMEZONE > /etc/timezone

# Base packages
# -----------------------------------------------------------------------------
RUN apk add --no-cache \
    openjdk7-jre

COPY ./sources /opt/solr
COPY ./init/solr /etc/init.d/solr
COPY ./bootstrap.sh /root/bootstrap.sh

RUN chmod 755 /root/bootstrap.sh && \
    chmod 755 /etc/init.d/solr

# -----------------------------------------------------------------------------

# Clear archives in cache folder
RUN rm -rf /var/cache/apk/*

EXPOSE 8983

WORKDIR /opt/solr

CMD ["/root/bootstrap.sh"]