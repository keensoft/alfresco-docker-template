FROM keensoft/base:centos7-openjdk8-tomcat7
LABEL maintainer "mikel.asla@keensoft.es"
LABEL version "1.0"
LABEL description "This is alfresco-docker-template version 201707-GA"

RUN set -x \
	&& yum install -y \
		unzip \
		wget \
	&& yum clean all

ENV ALF_DOWNLOAD_URL https://download.alfresco.com/release/community/201707-build-00028/alfresco-community-distribution-201707.zip
ENV ALF_HOME /usr/local/alfresco

RUN set -x \
	&& mkdir -p $ALF_HOME \
	&& wget --no-check-certificate $ALF_DOWNLOAD_URL \
	&& unzip alfresco-community-distribution-201707.zip -d /tmp \
	&& rm -f alfresco-community-distribution-201707.zip

WORKDIR $ALF_HOME
ENV DIST /tmp/alfresco-community-distribution-201707
ENV PATH $ALF_HOME/bin:$PATH
