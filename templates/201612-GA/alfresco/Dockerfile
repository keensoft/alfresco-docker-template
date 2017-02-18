FROM keensoft/alfresco-docker-template:201612-GA
MAINTAINER keensoft.es

RUN set -x \
	&& yum update -y \
	&& yum clean all

RUN set -x \
	&& yum install -y \
		ImageMagick \
		ghostscript \
	&& yum clean all

ENV ALF_HOME /usr/local/alfresco
ENV CATALINA_HOME /usr/local/alfresco/tomcat
WORKDIR $ALF_HOME

# basic configuration
RUN set -x \
        && ln -s /usr/local/tomcat /usr/local/alfresco/tomcat \
	&& mv $DIST/web-server/conf/Catalina tomcat/conf/ \
        && mv $DIST/web-server/shared tomcat/ \
        && mv $DIST/web-server/lib/*.jar tomcat/lib/ \
        && mv $DIST/web-server/webapps/alfresco.war tomcat/webapps/ \
        && mv $DIST/web-server/webapps/share.war tomcat/webapps/ \
	&& mv $DIST/web-server/webapps/solr4.war tomcat/webapps/ \
	&& mv $DIST/solr4/context.xml tomcat/conf/Catalina/localhost/solr4.xml \
	&& mv $DIST/solr4 . \
        && mv $DIST/alf_data . \
        && mv $DIST/amps . \
        && mv $DIST/bin . \
        && mv $DIST/licenses . \
        && mv $DIST/README.txt . \
        && rm -rf $CATALINA_HOME/webapps/docs \
        && rm -rf $CATALINA_HOME/webapps/examples \
        && mkdir $CATALINA_HOME/shared/lib $ALF_HOME/amps_share \
        && rm -rf $DIST 

COPY assets/tomcat/catalina.properties tomcat/conf/catalina.properties
COPY assets/tomcat/setenv.sh tomcat/bin/setenv.sh
COPY assets/alfresco/alfresco-global.properties tomcat/shared/classes/alfresco-global.properties

# Solr4 Configuration
RUN set -x \
    && sed -i 's,@@ALFRESCO_SOLR4_DIR@@,'"$ALF_HOME"'/solr4,g' tomcat/conf/Catalina/localhost/solr4.xml \
    && sed -i 's,@@ALFRESCO_SOLR4_MODEL_DIR@@,'"$ALF_HOME"'/alf_data/solr4/model,g' tomcat/conf/Catalina/localhost/solr4.xml \
    && sed -i 's,@@ALFRESCO_SOLR4_CONTENT_DIR@@,'"$ALF_HOME"'/alf_data/solr4/content,g' tomcat/conf/Catalina/localhost/solr4.xml \
    && sed -i 's,@@ALFRESCO_SOLR4_DATA_DIR@@,'"$ALF_HOME"'/alf_data/solr4/index,g' solr4/workspace-SpacesStore/conf/solrcore.properties \
    && sed -i 's,@@ALFRESCO_SOLR4_DATA_DIR@@,'"$ALF_HOME"'/alf_data/solr4/index,g' solr4/archive-SpacesStore/conf/solrcore.properties \
    && sed -i 's,alfresco.secureComms=https,alfresco.secureComms=none,g' solr4/workspace-SpacesStore/conf/solrcore.properties \
    && sed -i 's,alfresco.secureComms=https,alfresco.secureComms=none,g' solr4/archive-SpacesStore/conf/solrcore.properties


# AMPS installation
COPY assets/amps amps
COPY assets/amps_share amps_share
RUN bash ./bin/apply_amps.sh -force -nobackup

# Add api-explorer WAR file
COPY assets/api-explorer/api-explorer.war tomcat/webapps/api-explorer.war

ENV PATH $ALF_HOME/bin:$PATH
ENV LANG es_ES.utf8

RUN useradd -ms /bin/bash alfresco
RUN set -x && chown -RL alfresco:alfresco $ALF_HOME
USER alfresco

ENV JPDA_ADDRESS="9999"
ENV JPDA_TRANSPORT="dt_socket"

EXPOSE 8080 8009 9999
VOLUME $ALF_HOME/alf_data
CMD ["catalina.sh", "jpda", "run"]
