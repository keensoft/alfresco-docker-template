# alfresco-50d-docker-template


### Description

This template can be used to deploy custom Alfresco Community 5.0.d installations starting your Dockerfiles with
the following statement

	FROM keensoft/alfresco-50d
	

### Dockerfile example

	FROM keensoft/alfresco-50d
	MAINTAINER Mikel Asla mikel.asla@keensoft.es

	RUN yum update -y
	RUN yum install -y \
    	ImageMagick \
    	ghostscript

	ENV ZIP /tmp/alfresco/alfresco-community-$ALF_VERSION
	WORKDIR $ALF_HOME

	# basic configuration
	RUN set -x \
        	&& ln -s /usr/local/tomcat /usr/local/alfresco/tomcat \
        	&& mkdir -p $CATALINA_HOME/conf/Catalina/localhost \
        	&& mv $ZIP/solr4/context.xml tomcat/conf/Catalina/localhost/solr4.xml \
        	&& mv $ZIP/solr4 . \
        	&& mv $ZIP/web-server/shared tomcat/ \
        	&& mv $ZIP/web-server/endorsed tomcat/ \
        	&& mv $ZIP/web-server/lib/*.jar tomcat/lib/ \
        	&& mv $ZIP/web-server/webapps/alfresco.war tomcat/webapps/alfresco.war \
        	&& mv $ZIP/web-server/webapps/share.war tomcat/webapps/share.war \
        	&& mv $ZIP/web-server/webapps/solr4.war tomcat/webapps/solr4.war \
        	&& mv $ZIP/alf_data . \
        	&& mv $ZIP/amps . \
        	&& mv $ZIP/bin . \
        	&& mv $ZIP/licenses . \
        	&& mv $ZIP/README.txt . \
        	&& rm -rf $CATALINA_HOME/webapps/docs \
        	&& rm -rf $CATALINA_HOME/webapps/examples \
        	&& mkdir $CATALINA_HOME/shared/lib $ALF_HOME/amps_share

	RUN set -x \
    		&& sed -i 's,@@ALFRESCO_SOLR4_DIR@@,'"$ALF_HOME"'/solr4,g' tomcat/conf/Catalina/localhost/solr4.xml \
    		&& sed -i 's,@@ALFRESCO_SOLR4_MODEL_DIR@@,'"$ALF_HOME"'/alf_data/solr4/model,g' tomcat/conf/Catalina/localhost/solr4.xml \
    		&& sed -i 's,@@ALFRESCO_SOLR4_CONTENT_DIR@@,'"$ALF_HOME"'/alf_data/solr4/content,g' tomcat/conf/Catalina/localhost/solr4.xml \
    		&& sed -i 's,@@ALFRESCO_SOLR4_DATA_DIR@@,'"$ALF_HOME"'/alf_data/solr4/index,g' solr4/workspace-SpacesStore/conf/solrcore.properties \
    		&& sed -i 's,@@ALFRESCO_SOLR4_DATA_DIR@@,'"$ALF_HOME"'/alf_data/solr4/index,g' solr4/archive-SpacesStore/conf/solrcore.properties 

	COPY assets/tomcat/catalina.properties $CATALINA_HOME/conf/catalina.properties
	COPY assets/tomcat/server.xml $CATALINA_HOME/conf/server.xml
	COPY assets/tomcat/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml
	COPY assets/tomcat/setenv.sh $CATALINA_HOME/bin/setenv.sh
	COPY assets/alfresco/alfresco-global.properties $CATALINA_HOME/shared/classes/alfresco-global.properties

	# AMPS installation
	COPY assets/amps $ALF_HOME/amps
	COPY assets/amps_share $ALF_HOME/amps_share
	RUN bash $ALF_HOME/bin/apply_amps.sh -force

	ENV PATH $ALF_HOME/bin:$PATH

	EXPOSE 8080
	CMD ["catalina.sh", "run"]


### Components

*   [Centos 7](https://hub.docker.com/_/centos/)
*   [Oracle SUN JDK 8.0.45](http://www.oracle.com/technetwork/java/javaseproducts/downloads/index.html)
*   [Oracle SUN JDK 8.0.45](http://www.oracle.com/technetwork/java/javaseproducts/downloads/index.html)
*   [Apache Tomcat 7.0.67](https://www.apache.org/dist/tomcat/tomcat-7/v7.0.67/bin/apache-tomcat-7.0.67.tar.gz)
*   [Alfresco Community 5.0.d distribution ZIP file](https://process.alfresco.com/ccdl/?file=release/community/5.0.d-build-00002/alfresco-community-5.0.d.zip)  




