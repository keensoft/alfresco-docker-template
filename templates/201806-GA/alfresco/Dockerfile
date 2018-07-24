FROM alfresco/alfresco-content-repository-community:6.0.7-ga

# Add services configuration to alfresco-global.properties
RUN echo -e '\n\
alfresco.host=localhost\n\
alfresco.port=443\n\
alfresco.protocol=https\n\
\n\
share.host=localhost\n\
share.port=443\n\
share.protocol=https\n\
\n\
ftp.enabled=true\n\
ftp.port=2121\n\
\n\
imap.server.enabled=true\n\
imap.server.port=1143\n\
\n\
email.server.enabled=true\n\
email.server.port=2525\n\
\n\
cifs.enabled=true\n\
cifs.tcpipSMB.port=1445\n\
cifs.netBIOSSMB.namePort=1137\n\
cifs.netBIOSSMB.datagramPort=1138\n\
cifs.netBIOSSMB.sessionPort=1139\n\
\n\
' >> /usr/local/tomcat/shared/classes/alfresco-global.properties

# Extra software
RUN set -x \
	&& yum install -y \
	wget \
	unzip \
	&& yum clean all

# Install api-explorer webapp for REST API
RUN set -x \
    && wget https://artifacts.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco/api-explorer/6.0.7-ga/api-explorer-6.0.7-ga.war -O /usr/local/tomcat/webapps/api-explorer.war

ARG TOMCAT_DIR=/usr/local/tomcat

RUN mkdir -p $TOMCAT_DIR/amps

# Install AOS
RUN set -x \
        && mkdir /tmp/aos \
        && wget --no-check-certificate https://download.alfresco.com/cloudfront/release/community/201806-GA-build-00113/alfresco-aos-module-distributionzip-1.2.0.zip \
        && unzip alfresco-aos-module-distributionzip-1.2.0.zip -d /tmp/aos \
        && mv /tmp/aos/extension/* /usr/local/tomcat/shared/classes/alfresco/extension \
        && mv /tmp/aos/alfresco-aos-module-1.2.0.amp amps \
        && mv /tmp/aos/aos-module-license.txt licenses \
        && mv /tmp/aos/_vti_bin.war /usr/local/tomcat/webapps \
        && rm -rf /tmp/aos alfresco-aos-module-distributionzip-1.2.0.zip

# Install modules and addons
COPY modules/amps $TOMCAT_DIR/amps
COPY modules/jars $TOMCAT_DIR/webapps/alfresco/WEB-INF/lib

RUN java -jar $TOMCAT_DIR/alfresco-mmt/alfresco-mmt*.jar install \
            $TOMCAT_DIR/amps $TOMCAT_DIR/webapps/alfresco -directory -nobackup -force

EXPOSE 2121 1143 2525 1445 1137/udp 1138/udp 1139
