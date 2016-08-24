FROM keensoft/centos7-java8-tomcat7.0.69
MAINTAINER keensoft.es

RUN yum update -y
RUN yum install -y unzip 

ENV ALF_DOWNLOAD_URL http://dl.alfresco.com/release/community/5.0.d-build-00002/alfresco-community-5.0.d.zip
ENV ALF_HOME /usr/local/alfresco

RUN set -x \
	&& mkdir -p $ALF_HOME \
	&& wget $ALF_DOWNLOAD_URL \
	&& unzip alfresco-community-5.0.d.zip -d /tmp \
	&& rm -f alfresco-community-5.0.d.zip

WORKDIR $ALF_HOME
ENV DIST /tmp/alfresco-community-5.0.d
ENV PATH $ALF_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]
