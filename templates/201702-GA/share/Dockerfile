FROM keensoft/alfresco-docker-template:201702-GA
MAINTAINER keensoft.es

RUN set -x \
	&& yum update -y \
	&& yum clean all

ENV ALF_HOME /usr/local/alfresco
ENV CATALINA_HOME /usr/local/alfresco/tomcat
WORKDIR $ALF_HOME

# basic configuration
RUN set -x \
        && ln -s /usr/local/tomcat /usr/local/alfresco/tomcat \
	&& mkdir -p $CATALINA_HOME/conf/Catalina/localhost $CATALINA_HOME/shared/classes/alfresco/web-extensio $CATALINA_HOME/shared/lib $ALF_HOME/modules/share \
	&& mv $DIST/web-server/conf/Catalina/localhost/share.xml tomcat/conf/Catalina/localhost \
        && mv $DIST/web-server/webapps/share.war tomcat/webapps/ \
        && mv $DIST/bin . \
	&& mv $DIST/amps_share . \
        && mv $DIST/licenses . \
        && mv $DIST/README.txt . \
        && rm -rf $CATALINA_HOME/webapps/docs \
        && rm -rf $CATALINA_HOME/webapps/examples \
        && rm -rf $DIST 

COPY assets/tomcat/catalina.properties tomcat/conf/catalina.properties
COPY assets/tomcat/setenv.sh tomcat/bin/setenv.sh
COPY assets/share/share-config-custom.xml tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml

# AMPS installation
COPY assets/share/apply_share_amps.sh $ALF_HOME/bin/apply_amps.sh
COPY assets/amps_share amps_share
RUN bash ./bin/apply_amps.sh -force -nobackup

ENV PATH $ALF_HOME/bin:$PATH
ENV LANG es_ES.utf8

RUN useradd -ms /bin/bash alfresco
RUN set -x && chown -RL alfresco:alfresco $ALF_HOME
USER alfresco

EXPOSE 8080 8009
CMD ["catalina.sh", "run"]
