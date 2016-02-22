# alfresco-docker-template

*  5.1.e (201602-GA) , latest [5.1.e/DockerFile](https://github.com/keensoft/alfresco-docker-template/blob/master/5.1.e/Dockerfile)
*  5.0.d [5.0.d/DockerFile](https://github.com/keensoft/alfresco-docker-template/blob/master/5.0.d/Dockerfile)
*  4.2.c [4.2.c/DockerFile](https://github.com/keensoft/alfresco-docker-template/blob/master/4.2.c/Dockerfile)

### Description

This template can be used to deploy custom Alfresco Community installations starting your Dockerfiles with
the following statement

	FROM keensoft/alfresco-docker-template:latest

### Stack

*   [Centos 7](https://hub.docker.com/_/centos/)
*   [Oracle SUN JDK 8.0.45](http://www.oracle.com/technetwork/java/javaseproducts/downloads/index.html)
*   [Apache Tomcat 7.0.67](https://www.apache.org/dist/tomcat/tomcat-7/v7.0.67/bin/apache-tomcat-7.0.67.tar.gz)

### Dockerfile example

	FROM keensoft/alfresco-docker-template:latest

	RUN yum update -y
	RUN yum install -y \
    	ImageMagick \
    	ghostscript

	WORKDIR $ALF_HOME

	# basic configuration
	RUN set -x \
        	&& ln -s /usr/local/tomcat /usr/local/alfresco/tomcat \
        	&& mkdir -p $ALF_HOME/tomcat/conf/Catalina/localhost \
        	&& mv $DIST/solr4/context.xml tomcat/conf/Catalina/localhost/solr4.xml \
        	&& mv $DIST/solr4 . \
        	&& mv $DIST/web-server/shared tomcat/ \
        	&& mv $DIST/web-server/endorsed tomcat/ \
        	&& mv $DIST/web-server/lib/*.jar tomcat/lib/ \
        	&& mv $DIST/web-server/webapps/alfresco.war tomcat/webapps/alfresco.war \
        	&& mv $DIST/web-server/webapps/share.war tomcat/webapps/share.war \
        	&& mv $DIST/web-server/webapps/solr4.war tomcat/webapps/solr4.war \
        	&& mv $DIST/alf_data . \
        	&& mv $DIST/amps . \
        	&& mv $DIST/bin . \
        	&& mv $DIST/licenses . \
        	&& mv $DIST/README.txt . \
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

