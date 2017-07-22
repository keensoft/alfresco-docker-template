FROM ubuntu:xenial
MAINTAINER florent.aide@gmail.com

ENV DEBIAN_FRONTEND noninteractive
# version 1:4.2.8-0ubuntu2

RUN apt-get update && apt-get -y -q install libreoffice libreoffice-writer ure libreoffice-java-common libreoffice-core libreoffice-common openjdk-8-jre fonts-opensymbol hyphen-fr hyphen-de hyphen-en-us hyphen-it hyphen-ru fonts-dejavu fonts-dejavu-core fonts-dejavu-extra fonts-noto fonts-dustin fonts-f500 fonts-fanwood fonts-freefont-ttf fonts-liberation fonts-lmodern fonts-lyx fonts-sil-gentium fonts-texgyre fonts-tlwg-purisa && apt-get -q -y remove libreoffice-gnome
EXPOSE 8997

RUN adduser --home=/opt/libreoffice --disabled-password --gecos "" --shell=/bin/bash libreoffice

# replace default setup with a one disabling logos by default
ADD sofficerc /etc/libreoffice/sofficerc
ADD startoo.sh /opt/libreoffice/startoo.sh
VOLUME ["/tmp"]
RUN chmod +x /opt/libreoffice/startoo.sh

ENTRYPOINT ["/opt/libreoffice/startoo.sh"]
