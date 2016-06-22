FROM keensoft/centos7-java8-tomcat7
MAINTAINER Mikel Asla mikel.asla@keensoft.es

RUN yum update -y
RUN yum install -y \
    unzip \
    sed 

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
