FROM centos:centos7
MAINTAINER keensoft

RUN set -x \
	&& yum install -y \
	httpd \
	&& yum clean all

COPY assets/alfresco.conf /etc/httpd/conf.d/alfresco.conf

EXPOSE 80
CMD httpd -DFOREGROUND
