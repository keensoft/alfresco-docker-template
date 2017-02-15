FROM keensoft/centos7-java8-tomcat7

COPY assets/cas.war $CATALINA_HOME/webapps/cas.war
COPY assets/server.xml $CATALINA_HOME/conf/server.xml
COPY assets/keystore $CATALINA_HOME/conf/keystore

EXPOSE 8443


