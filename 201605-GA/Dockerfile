FROM keensoft/base:centos7-openjdk8-tomcat7
LABEL maintainer "mikel.asla@keensoft.es"
LABEL version "1.0"
LABEL description "This is alfresco-docker-template version 201605-GA"

RUN set -x \
	&& yum install -y \
		unzip \
		wget \
	&& yum clean all

ENV ALF_DOWNLOAD_URL http://dl.alfresco.com/release/community/201605-build-00010/alfresco-community-distribution-201605.zip
ENV ALF_HOME /usr/local/alfresco

RUN set -x \
	&& mkdir -p $ALF_HOME \
	&& wget $ALF_DOWNLOAD_URL \
	&& unzip alfresco-community-distribution-201605.zip -d /tmp \
	&& rm -f alfresco-community-distribution-201605.zip

WORKDIR $ALF_HOME
ENV DIST /tmp/alfresco-community-distribution-201605
ENV PATH $ALF_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]
