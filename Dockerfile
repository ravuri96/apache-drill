FROM centos:7

LABEL maintainer "Prem Ravuri <prem.ravuri@philips.com>"

LABEL application Apache_Drill

ARG APACHE_DRILL_VERSION=1.16.0

ENV CONFIG_FILE_PATH /apache-drill/conf/drill-override.conf

ENV CONFIG_FILE_TEMPLATE_PATH /drill-override.conf.template

EXPOSE 8047 31010 31011 31012

COPY entrypoint.sh /

RUN set -x && \
    yum install -y gettext java-1.8.0-openjdk-devel which wget tar && \
    wget -nv http://apache.cs.utah.edu/drill/drill-${APACHE_DRILL_VERSION}/apache-drill-${APACHE_DRILL_VERSION}.tar.gz && \
    tar zxf "apache-drill-${APACHE_DRILL_VERSION}.tar.gz" && \
    rm -rf  apache-drill-${APACHE_DRILL_VERSION}.tar.gz && \
    chmod 777 /entrypoint.sh && \
    ln -sv "apache-drill-${APACHE_DRILL_VERSION}" apache-drill && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    yum clean all

COPY core-site.xml /apache-drill/conf/core-site.xml
COPY drill-override.conf.template $CONFIG_FILE_TEMPLATE_PATH

ENTRYPOINT ["/entrypoint.sh"]