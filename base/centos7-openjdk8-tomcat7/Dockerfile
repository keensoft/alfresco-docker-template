FROM keensoft/base:centos7-openjdk8
LABEL maintainer "mikel.asla@keensoft.es"
LABEL version "1.0"
LABEL description "This is a base image of Centos 7 and OpenJDK 8 and Apache Tomcat 7.0.59"

RUN set -x \
	&& yum install -y \
		curl \
		gpg \
	&& yum clean all


ENV CATALINA_HOME=/usr/local/tomcat \
	TOMCAT_TGZ_URL=http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.59/bin/apache-tomcat-7.0.59.tar.gz

RUN set -x \
	&& gpg --keyserver pgp.mit.edu --recv-key D63011C7 \
	&& mkdir -p $CATALINA_HOME \
	&& curl -fSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
	&& curl -fSL "$TOMCAT_TGZ_URL.asc" -o tomcat.tar.gz.asc \
	&& gpg --verify tomcat.tar.gz.asc \
	&& tar -xvf tomcat.tar.gz --strip-components=1 -C $CATALINA_HOME \
	&& rm tomcat.tar.gz*

COPY assets/server.xml $CATALINA_HOME/conf/server.xml
COPY assets/setenv.sh $CATALINA_HOME/bin/setenv.sh
COPY assets/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

WORKDIR $CATALINA_HOME
ENV PATH $CATALINA_HOME/bin/:$PATH
EXPOSE 8080 8009
CMD ["catalina.sh", "run"]


