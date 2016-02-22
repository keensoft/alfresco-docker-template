FROM keensoft/centos7-java8-tomcat7
MAINTAINER Mikel Asla mikel.asla@entelgy.com

RUN yum update -y
RUN yum install -y \
    unzip \
    sed 

ENV ALF_DOWNLOAD_URL http://dl.alfresco.com/release/community/5.0.d-build-00002/alfresco-community-5.0.d.zip
ENV ALF_HOME /usr/local/alfresco

RUN set -x \
	&& mkdir -p $ALF_HOME \
	&& mkdir /tmp/alfresco \
	&& wget $ALF_DOWNLOAD_URL \
	&& unzip $ALF_ZIP -d /tmp/alfresco \
	&& rm -f $ALF_ZIP

WORKDIR $ALF_HOME

ENV PATH $ALF_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]
