FROM keensoft/centos7-java8-tomcat7
MAINTAINER Mikel Asla mikel.asla@entelgy.com

RUN yum update -y
RUN yum install -y \
    unzip \
    sed 

ENV ALF_DOWNLOAD_URL http://dl.alfresco.com/release/community/build-04576/alfresco-community-4.2.c.zip
ENV ALF_HOME /usr/local/alfresco

RUN set -x \
	&& mkdir -p $ALF_HOME \
	&& wget $ALF_DOWNLOAD_URL \
	&& unzip alfresco-community-4.2.c.zip -d /tmp \
	&& rm -f alfresco-community-4.2.c.zip

WORKDIR $ALF_HOME
ENV DIST /tmp/alfresco-community-4.2.c
ENV PATH $ALF_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]
