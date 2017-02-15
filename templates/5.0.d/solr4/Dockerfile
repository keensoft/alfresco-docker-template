FROM keensoft/alfresco-docker-template:5.0.d
MAINTAINER keensoft

RUN set -x \
	&& yum update -y \
	&& yum clean all

RUN set -x \ 
	&& yum install -y sed \
	&& yum clean all 

ENV ALF_HOME /usr/local/alfresco
ENV SOLR4_HOME $ALF_HOME/solr4

# basic Solr4 configuration
RUN set -x \
	&& ln -s /usr/local/tomcat /usr/local/alfresco/tomcat \
	&& mkdir -p tomcat/conf/Catalina/localhost \
	&& mv $DIST/web-server/webapps/solr4.war tomcat/webapps/ \
	&& mv $DIST/alf_data . \
	&& mv $DIST/solr4/context.xml tomcat/conf/Catalina/localhost/solr4.xml \
	&& mv $DIST/solr4 . \
	&& mv $DIST/licenses . \
	&& mv $DIST/README.txt . 

RUN set -x \
	&& sed -i 's,@@ALFRESCO_SOLR4_DIR@@,'"$ALF_HOME"'/solr4,g' tomcat/conf/Catalina/localhost/solr4.xml \
	&& sed -i 's,@@ALFRESCO_SOLR4_MODEL_DIR@@,'"$ALF_HOME"'/alf_data/solr4/model,g' tomcat/conf/Catalina/localhost/solr4.xml \
	&& sed -i 's,@@ALFRESCO_SOLR4_CONTENT_DIR@@,'"$ALF_HOME"'/alf_data/solr4/content,g' tomcat/conf/Catalina/localhost/solr4.xml \

	&& sed -i 's,@@ALFRESCO_SOLR4_DATA_DIR@@,'"$ALF_HOME"'/alf_data/solr4/index,g' solr4/workspace-SpacesStore/conf/solrcore.properties \
	&& sed -i 's,@@ALFRESCO_SOLR4_DATA_DIR@@,'"$ALF_HOME"'/alf_data/solr4/index,g' solr4/archive-SpacesStore/conf/solrcore.properties \

	&& sed -i 's,alfresco.host=localhost,alfresco.host=alfresco,g' solr4/workspace-SpacesStore/conf/solrcore.properties \
	&& sed -i 's,alfresco.host=localhost,alfresco.host=alfresco,g' solr4/archive-SpacesStore/conf/solrcore.properties \
	&& sed -i 's,alfresco.secureComms=https,alfresco.secureComms=none,g' solr4/workspace-SpacesStore/conf/solrcore.properties \
	&& sed -i 's,alfresco.secureComms=https,alfresco.secureComms=none,g' solr4/archive-SpacesStore/conf/solrcore.properties

# override web.xml
RUN set -x \
        && mkdir tomcat/webapps/solr4 \
        && unzip tomcat/webapps/solr4.war -d tomcat/webapps/solr4
COPY assets/solr4/web.xml tomcat/webapps/solr4/WEB-INF/web.xml

WORKDIR $SOLR4_HOME
ENV PATH $ALF_HOME/bin:$PATH
ENV LANG es_ES.utf8

RUN useradd -ms /bin/bash solr
RUN set -x && chown -RL solr:solr $ALF_HOME
USER solr

EXPOSE 8080
CMD ["catalina.sh", "run"]
