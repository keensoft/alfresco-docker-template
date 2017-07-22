FROM keensoft/base:centos7-openjdk8-tomcat7
MAINTAINER keensoft.es

RUN set -x \
	&& yum install -y \
		unzip \
		wget \
	&& yum clean all

ENV ALF_DOWNLOAD_URL https://download.alfresco.com/release/community/201704-build-00028/alfresco-community-distribution-201707.zip
ENV ALF_HOME /usr/local/alfresco

RUN set -x \
	&& mkdir -p $ALF_HOME \
	&& wget --no-check-certificate $ALF_DOWNLOAD_URL \
	&& unzip alfresco-community-distribution-201707.zip -d /tmp \
	&& rm -f alfresco-community-distribution-201707.zip

WORKDIR $ALF_HOME
ENV DIST /tmp/alfresco-community-distribution-201704
ENV PATH $ALF_HOME/bin:$PATH
