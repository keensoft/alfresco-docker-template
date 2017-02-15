FROM centos:centos7
MAINTAINER keensoft

RUN set -x \
	&& yum update -y \
	&& yum clean all

RUN set -x \
	&& yum install -y \
	httpd \
	mod_ssl

RUN set -x \
	&& mkdir -p /etc/pki/CA/{certs,crl,newcerts,private} \
	&& touch /etc/pki/CA/index.txt \
	&& echo 01 > /etc/pki/CA/serial \
	&& cd /etc/pki/CA \
	&& umask 077

COPY assets/pki/CA/private/cakey.pem /etc/pki/CA/private/cakey.pem
COPY assets/pki/CA/cacert.pem /etc/pki/CA/cacert.pem
COPY assets/pki/CA/private/server.key /etc/pki/tls/private/localhost.key
COPY assets/pki/CA/certs/server.crt /etc/pki/tls/certs/localhost.crt

RUN set -x \
	&& cp /etc/pki/CA/cacert.pem /etc/pki/tls/certs/cacert.pem \
	&& cd /etc/pki/tls/certs \
	&& ln -s cacert.pem $(openssl x509 -hash -noout -in cacert.pem).0

COPY assets/alfresco.conf /etc/httpd/conf.d/alfresco.conf

EXPOSE 80 443
CMD httpd -DFOREGROUND
