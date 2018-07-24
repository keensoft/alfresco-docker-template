FROM alfresco/alfresco-share:6.0.b

ARG TOMCAT_DIR=/usr/local/tomcat

RUN mkdir -p $TOMCAT_DIR/amps_share

COPY modules/amps_share $TOMCAT_DIR/amps_share
COPY modules/jars $TOMCAT_DIR/webapps/share/WEB-INF/lib

RUN java -jar $TOMCAT_DIR/alfresco-mmt/alfresco-mmt*.jar install \
            $TOMCAT_DIR/amps_share $TOMCAT_DIR/webapps/share -directory -nobackup -force