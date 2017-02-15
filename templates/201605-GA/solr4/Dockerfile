FROM keensoft/alfresco-docker-template:201605-GA
MAINTAINER keensoft

RUN set -x \
	&& yum update -y \
	&& yum clean all

RUN set -x \ 
	&& yum install -y sed \
	&& yum clean all 

WORKDIR $CATALINA_HOME
ENV SOLR4_HOME $CATALINA_HOME/solr4
ENV ALF_HOME $CATALINA_HOME

# basic Solr4 configuration
RUN set -x \
	&& mkdir -p conf/Catalina/localhost \
	&& mv $DIST/web-server/webapps/solr4.war webapps/solr4.war \
	&& mv $DIST/alf_data . \
	&& mv $DIST/solr4/context.xml conf/Catalina/localhost/solr4.xml \
	&& mv $DIST/solr4 . \
	&& mv $DIST/licenses . \
	&& mv $DIST/README.txt . 

RUN set -x \
	&& sed -i 's,@@ALFRESCO_SOLR4_DIR@@,'"$ALF_HOME"'/solr4,g' conf/Catalina/localhost/solr4.xml \
	&& sed -i 's,@@ALFRESCO_SOLR4_MODEL_DIR@@,'"$ALF_HOME"'/alf_data/solr4/model,g' conf/Catalina/localhost/solr4.xml \
	&& sed -i 's,@@ALFRESCO_SOLR4_CONTENT_DIR@@,'"$ALF_HOME"'/alf_data/solr4/content,g' conf/Catalina/localhost/solr4.xml \

	&& sed -i 's,@@ALFRESCO_SOLR4_DATA_DIR@@,'"$ALF_HOME"'/alf_data/solr4/index,g' solr4/workspace-SpacesStore/conf/solrcore.properties \
	&& sed -i 's,@@ALFRESCO_SOLR4_DATA_DIR@@,'"$ALF_HOME"'/alf_data/solr4/index,g' solr4/archive-SpacesStore/conf/solrcore.properties \

	&& sed -i 's,alfresco.host=localhost,alfresco.host=alfresco,g' solr4/workspace-SpacesStore/conf/solrcore.properties \
	&& sed -i 's,alfresco.host=localhost,alfresco.host=alfresco,g' solr4/archive-SpacesStore/conf/solrcore.properties \
	&& sed -i 's,alfresco.secureComms=https,alfresco.secureComms=none,g' solr4/workspace-SpacesStore/conf/solrcore.properties \
	&& sed -i 's,alfresco.secureComms=https,alfresco.secureComms=none,g' solr4/archive-SpacesStore/conf/solrcore.properties

ENV PATH $ALF_HOME/bin:$PATH
ENV LANG es_ES.utf8

RUN useradd -ms /bin/bash solr
RUN set -x && chown -RL solr:solr $ALF_HOME
USER solr

EXPOSE 8080
CMD ["catalina.sh", "run"]
