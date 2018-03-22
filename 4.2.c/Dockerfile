FROM keensoft/base:centos7-openjdk8-tomcat7
LABEL maintainer "mikel.asla@keensoft.es"
LABEL version "1.0"
LABEL description "This is alfresco-docker-template version 4.2.c"

RUN set -x \
	&& yum install -y \
		unzip \
		wget \
	&& yum clean all

ENV ALF_DOWNLOAD_URL http://dl.alfresco.com/release/community/build-04576/alfresco-community-4.2.c.zip
ENV SOLR_DOWNLOAD_URL http://dl.alfresco.com/release/community/build-04576/alfresco-community-solr-4.2.c.zip
ENV ALF_HOME /usr/local/alfresco

RUN set -x \
	&& mkdir -p $ALF_HOME \
	&& mkdir -p /tmp/alfresco \
	&& wget $ALF_DOWNLOAD_URL \
	&& unzip alfresco-community-4.2.c.zip -d /tmp/alfresco \
	&& rm -f alfresco-community-4.2.c.zip

RUN set -x \
	&& mkdir /tmp/solr \
	&& wget $SOLR_DOWNLOAD_URL \
	&& unzip alfresco-community-solr-4.2.c.zip -d /tmp/solr \
	&& rm alfresco-community-solr-4.2.c.zip

WORKDIR $ALF_HOME
ENV DIST /tmp/alfresco
ENV SOLR /tmp/solr
ENV PATH $ALF_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]
