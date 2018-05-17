FROM debian:stretch as dist

LABEL maintainer "mikel.asla@keensoft.es"
LABEL version "201804-EA"
LABEL description "This is alfresco-docker-template version 201804-EA"

ENV ALF_ARTIFACT_ID=alfresco-content-services-community-distribution \
	ALF_VERSION=6.0.5-ea \
	ALF_DOWNLOAD_URL=https://artifacts.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
	    unzip \
	    wget \
	
	&& mkdir -p /tmp/alfresco \
	&& wget --no-check-certificate $ALF_DOWNLOAD_URL/$ALF_ARTIFACT_ID/$ALF_VERSION/$ALF_ARTIFACT_ID-$ALF_VERSION.zip \
	&& unzip $ALF_ARTIFACT_ID-$ALF_VERSION.zip -d /tmp/alfresco 

FROM openjdk:8-jre as amps_install

ENV DIST /tmp/alfresco/alfresco-content-services-community-distribution-6.0.5-ea

WORKDIR /tmp

COPY --from=dist $DIST/bin/alfresco-mmt.jar alfresco-mmt.jar
COPY --from=dist $DIST/web-server/webapps/alfresco.war alfresco.war
COPY --from=dist $DIST/amps/alfresco-share-services.amp alfresco-share-services.amp

RUN set -x \
	&& java -jar alfresco-mmt.jar install alfresco-share-services.amp alfresco.war -nobackup

FROM tomcat:7-jre8-alpine

ENV DIST /tmp/alfresco/alfresco-content-services-community-distribution-6.0.5-ea

COPY --from=dist $DIST/web-server/lib/postgresql-42.2.1.jar /usr/local/tomcat/lib/postgresql-42.2.1.jar
COPY --from=dist $DIST/web-server/webapps/ROOT.war /usr/local/tomcat/webapps/ROOT.war
COPY --from=amps_install /tmp/alfresco.war /usr/local/tomcat/webapps/alfresco.war

RUN set -x \
	&& cd webapps \
	&& rm -rf ROOT manager docs examples host-manager \
	&& mkdir alfresco ROOT \
	&& unzip alfresco.war -d alfresco \
	&& unzip ROOT.war -d ROOT \
	&& rm -rf *.war
