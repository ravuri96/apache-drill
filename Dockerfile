FROM alpine:latest

LABEL maintainer "Prem Ravuri <ravuripremchand@gmail.com>"

LABEL application Apache_Drill

ARG APACHE_DRILL_VERSION=1.16.0

ENV APPLICATION_HOME /

ENV CONFIG_FILE_PATH /apache-drill/conf/drill-override.conf

ENV CONFIG_FILE_TEMPLATE_PATH ${APPLICATION_HOME}/drill-override.conf.template

WORKDIR ${APPLICATION_HOME}

EXPOSE 8047 31010 31011 31012

COPY entrypoint.sh /

RUN set -x && \
    apk add --update libintl && \
    apk add --virtual build_deps gettext &&  \
    apk add --no-cache bash openjdk8 which wget tar && \
    wget -nv http://apache.cs.utah.edu/drill/drill-${APACHE_DRILL_VERSION}/apache-drill-${APACHE_DRILL_VERSION}.tar.gz && \
    tar zxf "apache-drill-${APACHE_DRILL_VERSION}.tar.gz" && \
    rm -rf  apache-drill-${APACHE_DRILL_VERSION}.tar.gz && \
    chmod 777 /entrypoint.sh && \
    ln -sv "apache-drill-${APACHE_DRILL_VERSION}" apache-drill && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps wget tar

COPY drill-override.conf.template $CONFIG_FILE_TEMPLATE_PATH

HEALTHCHECK CMD curl --fail http://localhost:8047/ || exit 1

ENTRYPOINT ["/entrypoint.sh"]