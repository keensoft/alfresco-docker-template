FROM keensoft/alfresco-docker-template:4.2.c
MAINTAINER keensoft.es

RUN set -x \
	&& yum update -y \
	&& yum clean all

RUN set -x \
	&& yum install -y ImageMagick ghostscript \
	&& yum clean all

ENV ALF_HOME /usr/local/alfresco
ENV CATALINA_HOME /usr/local/alfresco/tomcat
WORKDIR $ALF_HOME

# basic configuration
RUN set -x \
        && ln -s /usr/local/tomcat /usr/local/alfresco/tomcat \
	&& mkdir -p tomcat/conf/Catalina/localhost \
        && mv $DIST/web-server/shared tomcat/ \
        && mv $DIST/web-server/lib/*.jar tomcat/lib/ \
        && mv $DIST/web-server/webapps/alfresco.war tomcat/webapps/ \
        && mv $DIST/web-server/webapps/share.war tomcat/webapps/ \
        && mv $DIST/bin . \
        && mv $DIST/licenses . \
        && mv $DIST/README.txt . \
        && rm -rf $CATALINA_HOME/webapps/docs \
        && rm -rf $CATALINA_HOME/webapps/examples \
        && mkdir $CATALINA_HOME/shared/lib $ALF_HOME/amps_share \
        && rm -rf $DIST

COPY assets/tomcat/catalina.properties tomcat/conf/catalina.properties
COPY assets/tomcat/setenv.sh tomcat/bin/setenv.sh
COPY assets/tomcat/server.xml tomcat/conf/server.xml
COPY assets/tomcat/tomcat-users.xml tomcat/conf/tomcat-users.xml
COPY assets/alfresco/alfresco-global.properties tomcat/shared/classes/alfresco-global.properties

# Solr installation
RUN set -x \
        && mv $SOLR/alf_data . \
        && mkdir alf_data/solr \
        && mv $SOLR/docs alf_data/solr \
        && mv $SOLR/workspace-SpacesStore alf_data/solr \
        && mv $SOLR/archive-SpacesStore alf_data/solr \
        && mv $SOLR/templates alf_data/solr \
        && mv $SOLR/lib alf_data/solr \
        && mv $SOLR/solr.xml alf_data/solr \
        && mv $SOLR/*.war* alf_data/solr \
        && rm -rf $SOLR

COPY assets/solr/solr-tomcat-context.xml tomcat/conf/Catalina/localhost/solr.xml
COPY assets/solr/workspace-solrcore.properties alf_data/solr/workspace-SpacesStore/conf/solrcore.properties
COPY assets/solr/archive-solrcore.properties alf_data/solr/archive-SpacesStore/conf/solrcore.properties

# AMPS installation
COPY assets/amps amps
COPY assets/amps_share amps_share
RUN bash ./bin/apply_amps.sh -force -nobackup

# JARS installation
#COPY assets/jars/*.jar $CATALINA_HOME/shared/lib/

ENV PATH $ALF_HOME/bin:$PATH
ENV LANG es_ES.utf8

RUN useradd -ms /bin/bash alfresco
RUN set -x && chown -RL alfresco:alfresco $ALF_HOME
USER alfresco

VOLUME $ALF_HOME/alf_data
EXPOSE 8080 8009
CMD ["catalina.sh", "run"]
