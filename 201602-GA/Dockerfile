FROM keensoft/base:centos7-openjdk8-tomcat7
LABEL maintainer "mikel.asla@keensoft.es"
LABEL version "1.0"
LABEL description "This is alfresco-docker-template version 201602-GA"

RUN set -x \
	&& yum install -y \
		unzip \
		wget \
	&& yum clean all

ENV ALF_DOWNLOAD_URL http://dl.alfresco.com/release/community/201602-build-00005/alfresco-community-distribution-201602.zip
ENV ALF_HOME /usr/local/alfresco

RUN set -x \
	&& mkdir -p $ALF_HOME \
	&& wget $ALF_DOWNLOAD_URL \
	&& unzip alfresco-community-distribution-201602.zip -d /tmp \
	&& rm -f alfresco-community-distribution-201602.zip

WORKDIR $ALF_HOME
ENV DIST /tmp/alfresco-community-distribution-201602
ENV PATH $ALF_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]
