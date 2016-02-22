FROM keensoft/alfresco-docker-template:latest
MAINTAINER Mikel Asla mikel.asla@keensoft.es

RUN yum update -y
RUN yum install -y \
    ImageMagick \
    ghostscript

WORKDIR $ALF_HOME

# basic configuration
RUN set -x \
        && ln -s /usr/local/tomcat /usr/local/alfresco/tomcat \
        && mkdir -p $ALF_HOME/tomcat/conf/Catalina/localhost \
        && mv $ZIP/solr4/context.xml tomcat/conf/Catalina/localhost/solr4.xml \
        && mv $ZIP/solr4 . \
        && mv $ZIP/web-server/shared tomcat/ \
        && mv $ZIP/web-server/endorsed tomcat/ \
        && mv $ZIP/web-server/lib/*.jar tomcat/lib/ \
        && mv $ZIP/web-server/webapps/alfresco.war tomcat/webapps/alfresco.war \
        && mv $ZIP/web-server/webapps/share.war tomcat/webapps/share.war \
	&& mkdir tomcat/webapps/solr4 \
        && mv $ZIP/alf_data . \
        && mv $ZIP/amps . \
        && mv $ZIP/bin . \
        && mv $ZIP/licenses . \
        && mv $ZIP/README.txt . \
        && rm -rf $CATALINA_HOME/webapps/docs \
        && rm -rf $CATALINA_HOME/webapps/examples \
        && mkdir $CATALINA_HOME/shared/lib $ALF_HOME/amps_share

RUN set -x \
	&& unzip $ZIP/web-server/webapps/solr4.war -d tomcat/webapps/solr4 \
        && rm -rf $ZIP 

RUN set -x \
    && sed -i 's,@@ALFRESCO_SOLR4_DIR@@,'"$ALF_HOME"'/solr4,g' tomcat/conf/Catalina/localhost/solr4.xml \
    && sed -i 's,@@ALFRESCO_SOLR4_MODEL_DIR@@,'"$ALF_HOME"'/alf_data/solr4/model,g' tomcat/conf/Catalina/localhost/solr4.xml \
    && sed -i 's,@@ALFRESCO_SOLR4_CONTENT_DIR@@,'"$ALF_HOME"'/alf_data/solr4/content,g' tomcat/conf/Catalina/localhost/solr4.xml \
    && sed -i 's,@@ALFRESCO_SOLR4_DATA_DIR@@,'"$ALF_HOME"'/alf_data/solr4/index,g' solr4/workspace-SpacesStore/conf/solrcore.properties \
    && sed -i 's,@@ALFRESCO_SOLR4_DATA_DIR@@,'"$ALF_HOME"'/alf_data/solr4/index,g' solr4/archive-SpacesStore/conf/solrcore.properties \
    && sed -i 's,alfresco.secureComms=https,alfresco.secureComms=none,g' solr4/workspace-SpacesStore/conf/solrcore.properties \
    && sed -i 's,alfresco.secureComms=https,alfresco.secureComms=none,g' solr4/archive-SpacesStore/conf/solrcore.properties 

COPY assets/tomcat/catalina.properties $ALF_HOME/tomcat/conf/catalina.properties
COPY assets/tomcat/setenv.sh $ALF_HOME/tomcat/bin/setenv.sh
COPY assets/alfresco/alfresco-global.properties $ALF_HOME/tomcat/shared/classes/alfresco-global.properties
COPY assets/solr4/web.xml $ALF_HOME/tomcat/webapps/solr4/WEB-INF/web.xml

# AMPS installation
COPY assets/amps $ALF_HOME/amps
COPY assets/amps_share $ALF_HOME/amps_share
RUN bash $ALF_HOME/bin/apply_amps.sh -force

ENV PATH $ALF_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]
