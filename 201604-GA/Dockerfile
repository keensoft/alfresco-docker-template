FROM keensoft/centos7-java8-tomcat7.0.69
MAINTAINER keensoft.es

RUN yum update -y
RUN yum install -y unzip

ENV ALF_DOWNLOAD_URL http://dl.alfresco.com/release/community/201604-build-00007/alfresco-community-distribution-201604.zip
ENV ALF_HOME /usr/local/alfresco

RUN set -x \
	&& mkdir -p $ALF_HOME \
	&& wget $ALF_DOWNLOAD_URL \
	&& unzip alfresco-community-distribution-201604.zip -d /tmp \
	&& rm -f alfresco-community-distribution-201604.zip

WORKDIR $ALF_HOME
ENV DIST /tmp/alfresco-community-distribution-201604
ENV PATH $ALF_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]
