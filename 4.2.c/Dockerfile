FROM keensoft/centos7-java8-tomcat7
MAINTAINER Mikel Asla mikel.asla@entelgy.com

RUN yum update -y
RUN yum install -y \
    unzip \
    sed 

ENV ALF_DOWNLOAD_URL https://process.alfresco.com/ccdl/?file=release/community/build-04576/alfresco-community-4.2.c.zip
ENV ALF_HOME /usr/local/alfresco

RUN set -x \
	&& mkdir -p $ALF_HOME \
	&& wget $ALF_DOWNLOAD_URL \
	&& unzip $ALF_ZIP -d /tmp \
	&& rm -f $ALF_ZIP

WORKDIR $ALF_HOME
ENV DIST /tmp/alfresco-community-4.2.c
ENV PATH $ALF_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]
