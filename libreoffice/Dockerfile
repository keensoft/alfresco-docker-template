FROM ubuntu:xenial
LABEL maintainer "mikel.asla@keensoft.es"
LABEL version "1.0"
LABEL description "This is alfresco-docker-template version 201707-GA" 

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
	&& apt-get update \
	&& apt-get -y -q install \
		hyphen-* \
		libreoffice \
		libreoffice-writer \
		libreoffice-java-common \ 
		libreoffice-core \ 
		libreoffice-common \ 
		openjdk-8-jre \
		ure \
	&& apt-get -q -y remove libreoffice-gnome\
	&& apt-get clean


RUN set -x \
	&& adduser --home=/opt/libreoffice --disabled-password --gecos "" --shell=/bin/bash libreoffice

ADD sofficerc /etc/libreoffice/sofficerc
ADD startoo.sh /opt/libreoffice/startoo.sh
RUN set -x \
	&& chmod +x /opt/libreoffice/startoo.sh
VOLUME ["/tmp"]
EXPOSE 8100
ENTRYPOINT ["/opt/libreoffice/startoo.sh"]
