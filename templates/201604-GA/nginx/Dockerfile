FROM nginx:stable
MAINTAINER keensoft

RUN set -x \
	&& mkdir /etc/nginx/ssl

COPY assets/pki/localhost.crt /etc/nginx/ssl/localhost.crt
COPY assets/pki/localhost.key /etc/nginx/ssl/localhost.key
COPY assets/nginx.conf /etc/nginx/nginx.conf
COPY assets/alfresco.conf /etc/nginx/conf.d/alfresco.conf


