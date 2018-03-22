FROM keensoft/base:centos7-openjdk8-tomcat7
LABEL maintainer "mikel.asla@keensoft.es"
LABEL version "1.0"
LABEL description "This is alfresco-docker-template version 201702-GA"

RUN set -x \
	&& yum install -y \
		unzip \
		wget \
	&& yum clean all
	
ENV ALF_DOWNLOAD_URL https://download.alfresco.com/release/community/201702-build-00016/alfresco-community-distribution-201702.zip
ENV ALF_HOME /usr/local/alfresco

RUN set -x \
	&& mkdir -p $ALF_HOME \
	&& wget --no-check-certificate $ALF_DOWNLOAD_URL \
	&& unzip alfresco-community-distribution-201702.zip -d /tmp \
	&& rm -f alfresco-community-distribution-201702.zip

WORKDIR $ALF_HOME
ENV DIST /tmp/alfresco-community-distribution-201702
ENV PATH $ALF_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]
