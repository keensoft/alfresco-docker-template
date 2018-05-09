FROM keensoft/alfresco-docker-template:201707-GA
MAINTAINER keensoft.es

RUN set -x \
	&& yum install -y \
	ImageMagick \
	ghostscript \
        postgresql \
	&& yum clean all

ENV ALF_HOME /usr/local/alfresco
ENV CATALINA_HOME /usr/local/alfresco/tomcat
WORKDIR $ALF_HOME

# basic configuration
RUN set -x \
        && ln -s /usr/local/tomcat /usr/local/alfresco/tomcat \
	&& mkdir -p $CATALINA_HOME/conf/Catalina/localhost $CATALINA_HOME/shared/classes/alfresco/extension $CATALINA_HOME/shared/lib $ALF_HOME/modules/platform \
        && mv $DIST/web-server/lib/*.jar tomcat/lib/ \
        && mv $DIST/web-server/webapps/alfresco.war tomcat/webapps/ \
        && mv $DIST/alf_data . \
        && mv $DIST/amps . \
        && mv $DIST/bin . \
        && mv $DIST/licenses . \
        && mv $DIST/README.txt . \
        && rm -rf $CATALINA_HOME/webapps/docs \
        && rm -rf $CATALINA_HOME/webapps/examples \
        && rm -rf $DIST 

COPY assets/tomcat/catalina.properties tomcat/conf/catalina.properties
COPY assets/tomcat/setenv.sh tomcat/bin/setenv.sh
COPY assets/tomcat/alfresco.xml tomcat/conf/Catalina/localhost/
COPY assets/alfresco/alfresco-global.properties tomcat/shared/classes/alfresco-global.properties

# alfresco-pdf-renderer 
RUN set -x \
	&& mkdir /usr/local/alfresco/alfresco-pdf-renderer \
	&& wget https://artifacts.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco/alfresco-pdf-renderer/1.0/alfresco-pdf-renderer-1.0-linux.tgz \
	&& tar xzvf alfresco-pdf-renderer-1.0-linux.tgz -C /usr/local/alfresco/alfresco-pdf-renderer \
	&& rm -f alfresco-pdf-renderer-1.0-linux.tgz 

# AMPS installation
COPY assets/alfresco/apply_alfresco_amps.sh $ALF_HOME/bin/apply_amps.sh
COPY assets/amps amps
RUN bash ./bin/apply_amps.sh -nobackup

# JARS installation
COPY assets/jars/ $ALF_HOME/modules/platform

# Add api-explorer WAR file
RUN set -x \
	&& wget https://artifacts.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco/api-explorer/5.2.0/api-explorer-5.2.0.war -O tomcat/webapps/api-explorer.war

ENV PATH $ALF_HOME/bin:$PATH
ENV LANG es_ES.utf8

COPY assets/wait-for-postgres.sh wait-for-postgres.sh
RUN set -x && chmod +x wait-for-postgres.sh

RUN useradd -ms /bin/bash alfresco
RUN set -x && chown -RL alfresco:alfresco $ALF_HOME
USER alfresco

RUN set -x \
        && echo "db:5432:alfresco:alfresco:alfresco" > /home/alfresco/.pgpass \
        && chmod 0600 /home/alfresco/.pgpass \
        && chown alfresco:alfresco /home/alfresco/.pgpass

ENV JPDA_ADDRESS="9999"
ENV JPDA_TRANSPORT="dt_socket"

EXPOSE 8080 8009 9999
VOLUME $ALF_HOME/alf_data
CMD ["./wait-for-postgres.sh", "db", "catalina.sh", "jpda", "run"]
