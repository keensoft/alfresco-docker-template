# Entorno para la Integración de Alfresco 201605 y CAS 4.0.1 para la UPTC

## Descripción general el entorno

* Se configura un Apache por delante de Alfresco y otro por delante de Share
* Se compila y se se configura mod_auth_cas en ambos Apaches
* Se deshabilita la autenticación en ambos tomcats de Alfresco y Share
* Se configura Alfresco y Share para la autenticación externa

## Imágenes Docker

* afresco : Alfresco 5.1.g
* postgres: PostgreSQL 9.4
* alfresco-httpd: Apache HTTPD 2.4 + mod_auth_cas
* share: Share 5.1.f
* solr4: Solr 4
* share-httpd: Apadche HTTD 2.4 + mod_auth_cas
* cas : CAS Server 4.0.1 (webapp sobre tomcat)
* openldap : openldap 2.4.10


## Artefactos necesarios

Los artefactos están ubicados en nuestro [repositorio Git](http://bitbucket.oficina.keensoft.es:7990/scm/upcalf/alfresco.git)

* cas-server-webapp

Aplicación Web CAS 4.0.1 configurada tal y como se describe más adelante

* cas-slingshotSSOConnector-share

AMP que implementa el parche aportado por Ian Wright en la issue [MNT-15795](https://issues.alfresco.com/jira/browse/MNT-15795)

## Configuración de Alfresco

Alfresco se configura para la autenticación externa del siguiente modo

```
$ vi /usr/local/alfresco/tomcat/shared/classes/alfresco-global.properties
$ cat /usr/local/alfresco/tomcat/shared/classes/alfresco-global.propoerties
authentication.chain=external1:external
external.authentication.proxyUserName=
external.authentication.defaultAdministratorUserNames=admin
external.authentication.proxyHeader=X-Alfresco-Remote-User
```

## Configuración de Share

En Share se configura la sección Remote para el SSO del siguiente modo

```
$ vi /usr/local/alfresco/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml
$ cat /usr/local/alfresco/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml
<config evaluator="string-compare" condition="Remote">
      <remote>
         <connector>
            <id>alfrescoHeader</id>
            <name>Alfresco Connector</name>
            <description>Connects to an Alfresco instance using header and cookie-based authentication</description>
            <class>es.keensoft.alfresco.web.site.servlet.SlingshotAlfrescoConnector</class>
            <userHeader>X-Alfresco-Remote-User</userHeader>
         </connector>

         <endpoint>
            <id>alfresco</id>
            <name>Alfresco - user access</name>
            <description>Access to Alfresco Repository WebScripts that require user authentication</description>
            <connector-id>alfrescoHeader</connector-id>
            <endpoint-url>http://alfresco:8080/alfresco/wcs</endpoint-url>
            <identity>user</identity>
            <external-auth>true</external-auth>
         </endpoint>
      </remote>
   </config>
```

# Configuración de los Tomcats de Alfresco y Share

Tanto en Alfresco como en Share, se añade el atributo tomcatAuthenticate=false a los conectores AJP

```
$ vi /usr/local/alfresco/tomcat/conf/server.xml
$ cat /usr/local/alfresco/tomcat/conf/server.xml
<!-- Define an AJP 1.3 Connector on port 8009 -->
    <Connector port="8009" protocol="AJP/1.3" URIEncoding="UTF-8" redirectPort="8443" tomcatAuthentication="false"/>
```

# Apache HTTPD

Pasos realizados para compilar y configurar mod_auth_cas en ambos Apaches

## alfresco-httpd

```
$ svn co https://source.jasig.org/cas-clients/mod_auth_cas/tags/mod_auth_cas-1.0.9.1 mod_auth_cas-1.0.9.1
$ cd mod_auth_cas-1.0.9.1
$ sed -i 's,CRYPTO_THREADID_get_id_callback,CRYPTO_THREADID_get_callback,g' src/mod_auth_cas.c
$ sed -i 's,CRYPTO_THREADID_set_id_callback,CRYPTO_THREADID_set_callback,g' src/mod_auth_cas.c
$ ./configure
$ make
$ make install
$ mkdir /var/lib/cas
$ chown apache:apache /var/lib/cas
$ chmod 0700 /var/lib/cas

$ vi /etc/httpd/conf.d/alfresco.conf
$ cat /etc/httpd/conf.d/alfresco.conf
<VirtualHost *:80>
        ServerName alfuptc.keensoft.es

        RewriteEngine on
        RewriteCond %{HTTPS} !=on
        RewriteRule ^/(.*) https://%{SERVER_NAME}/$1 [R,L]

</VirtualHost>

<VirtualHost *:443>
        ServerName alfuptc.keensoft.es

        SSLEngine on
        SSLCertificateFile /etc/pki/tls/certs/localhost.crt
        SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
        SSLVerifyClient optional
        SSLCACertificatePath /etc/pki/tls/certs/
        SSLOptions +StdEnvVars +ExportCertData

        LoadModule auth_cas_module modules/mod_auth_cas.so
        CASCookiePath /var/lib/cas/
        CASLoginURL https://cas:8443/cas/login
        CASValidateURL https://cas:8443/cas/serviceValidate
        CASValidateServer Off
        CASDebug On
        CASCertificatePath /etc/pki/tls/certs

        <LocationMatch ^/alfresco/(?!service/|service$|webdav/|webdav$|s/|s$|scripts/|css/|images/).*>
                AuthType CAS
                AuthName "CAS"
                require valid-user
                CASScope /alfresco
        </LocationMatch>

        ProxyPass /alfresco ajp://localhost:8009/alfresco
        ProxyPassReverse /alfresco ajp://localhost:8009/alfresco

</VirtualHost>
```

## share-httpd

La descarga y compilación de mod_auth_cas se omite al ser idéntica que para alfresco-httpd.


```
$ vi /etc/httpd/conf.d/share.conf
$ cat /etc/httpd/conf.d/share.conf
<VirtualHost *:80>
        ServerName shruptc.keensoft.es

        RewriteEngine on
        RewriteCond %{HTTPS} !=on
        RewriteRule ^/(.*) https://%{SERVER_NAME}/$1 [R,L]

</VirtualHost>

<VirtualHost *:443>
        ServerName shruptc.keensoft.es

        SSLEngine on
        SSLCertificateFile /etc/pki/tls/certs/localhost.crt
        SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
        SSLVerifyClient optional
        SSLCACertificatePath /etc/pki/tls/certs/
        SSLOptions +StdEnvVars +ExportCertData

        LoadModule auth_cas_module modules/mod_auth_cas.so
        CASCookiePath /var/lib/cas/
        CASLoginURL https://cas:8443/cas/login
        CASValidateURL https://cas:8443/cas/serviceValidate
        CASValidateServer Off
        CASDebug On
        CASCertificatePath /etc/pki/tls/certs

        <Location /share>
                AuthType CAS
                AuthName "CAS"
                require valid-user
                CASScope /share
        </Location>

        ProxyPass /share ajp://localhost:8009/share
        ProxyPassReverse /share ajp://localhost:8009/share

</VirtualHost>
```

## CAS Server 4.0.1

A continuación se describen los pasos realizados para montar el servidor de CAS


* Se descargan las fuentes del proyecto de CAS 4.0.1 (únicamente se requiere el artefacto cas-server-webapp contenido en el tar.gz)

```
$ wget https://github.com/apereo/cas/archive/v4.0.1.tar.gz
$ tar xzvf v4.0.1.tar.gz
$ cp -R cas-4.0.1/cas-server-webapp/ .
$ rm -rf v4.0.1.tar.gz cas-4.0.1
$ cd cas-server-webapp
```

* Se edita el pom.xml para añadir el soporte con ldap

```xml
<dependencies>
...
    </dependency>
	<dependency>
	    <groupId>org.springframework.ldap</groupId>
	    <artifactId>spring-ldap-core</artifactId>
	    <version>2.1.0.RELEASE</version>
	</dependency>
    <dependency>
    <dependency>
    	<groupId>org.jasig.cas</groupId>
    	<artifactId>cas-server-support-ldap</artifactId>
    	<version>${project.version}</version>
    </dependency>
</dependencies>

```
* Se edita el fichero de propiedades **src/main/webapp/WEB-INF/cas.properties**

```
#
# Licensed to Jasig under one or more contributor license
# agreements. See the NOTICE file distributed with this work
# for additional information regarding copyright ownership.
# Jasig licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file
# except in compliance with the License.  You may obtain a
# copy of the License at the following location:
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

server.name=https://cas:8443
server.prefix=${server.name}/cas
# IP address or CIDR subnet allowed to access the /status URI of CAS that exposes health check information
cas.securityContext.status.allowedSubnet=127.0.0.1


cas.themeResolver.defaultThemeName=cas-theme-default
cas.viewResolver.basename=default_views

##
# Unique CAS node name
# host.name is used to generate unique Service Ticket IDs and SAMLArtifacts.  This is usually set to the specific
# hostname of the machine running the CAS node, but it could be any label so long as it is unique in the cluster.
host.name=cas

##
# Database flavors for Hibernate
#
# One of these is needed if you are storing Services or Tickets in an RDBMS via JPA.
#
# database.hibernate.dialect=org.hibernate.dialect.OracleDialect
# database.hibernate.dialect=org.hibernate.dialect.MySQLInnoDBDialect
# database.hibernate.dialect=org.hibernate.dialect.HSQLDialect

##
# CAS Logout Behavior
# WEB-INF/cas-servlet.xml
#
# Specify whether CAS should redirect to the specified service parameter on /logout requests
# cas.logout.followServiceRedirects=false

##
# Single Sign-On Session Timeouts
# Defaults sourced from WEB-INF/spring-configuration/ticketExpirationPolices.xml
#
# Maximum session timeout - TGT will expire in maxTimeToLiveInSeconds regardless of usage
# tgt.maxTimeToLiveInSeconds=28800
#
# Idle session timeout -  TGT will expire sooner than maxTimeToLiveInSeconds if no further requests
# for STs occur within timeToKillInSeconds
# tgt.timeToKillInSeconds=7200

##
# Service Ticket Timeout
# Default sourced from WEB-INF/spring-configuration/ticketExpirationPolices.xml
#
# Service Ticket timeout - typically kept short as a control against replay attacks, default is 10s.  You'll want to
# increase this timeout if you are manually testing service ticket creation/validation via tamperdata or similar tools
# st.timeToKillInSeconds=10

##
# Single Logout Out Callbacks
# Default sourced from WEB-INF/spring-configuration/argumentExtractorsConfiguration.xml
#
# To turn off all back channel SLO requests set slo.disabled to true
# slo.callbacks.disabled=false

##
# Service Registry Periodic Reloading Scheduler
# Default sourced from WEB-INF/spring-configuration/applicationContext.xml
#
# Force a startup delay of 2 minutes.
# service.registry.quartz.reloader.startDelay=120000
#
# Reload services every 2 minutes
# service.registry.quartz.reloader.repeatInterval=120000

##
# Log4j
# Default sourced from WEB-INF/spring-configuration/log4jConfiguration.xml:
#
# It is often time helpful to externalize log4j.xml to a system path to preserve settings between upgrades.
# e.g. log4j.config.location=/etc/cas/log4j.xml
# log4j.config.location=classpath:log4j.xml
#
# log4j refresh interval in millis
# log4j.refresh.interval=60000

##
# Password Policy
#
# Warn all users of expiration date regardless of warningDays value.
password.policy.warnAll=false

# Threshold number of days to begin displaying password expiration warnings.
password.policy.warningDays=30

# URL to which the user will be redirected to change the passsword.
password.policy.url=https://password.example.edu/change
```

* Se añade el fichero de propiedades **src/main/webapp/WEB-INF/ldap.properties**

```
#========================================
# General properties
#========================================
ldap.url=ldap://ldap

# LDAP connection timeout in milliseconds
ldap.connectTimeout=3000

# Whether to use StartTLS (probably needed if not SSL connection)
ldap.useStartTLS=false

#========================================
# LDAP connection pool configuration
#========================================
ldap.pool.minSize=3
ldap.pool.maxSize=10
ldap.pool.validateOnCheckout=false
ldap.pool.validatePeriodically=true

# Amount of time in milliseconds to block on pool exhausted condition
# before giving up.
ldap.pool.blockWaitTime=3000

# Frequency of connection validation in seconds
# Only applies if validatePeriodically=true
ldap.pool.validatePeriod=300

# Attempt to prune connections every N seconds
ldap.pool.prunePeriod=300

# Maximum amount of time an idle connection is allowed to be in
# pool before it is liable to be removed/destroyed
ldap.pool.idleTime=600

#========================================
# Authentication
#========================================

# Base DN of users to be authenticated
ldap.authn.baseDn=ou=People,dc=keensoft,dc=es

# Manager DN for authenticated searches
ldap.authn.managerDn=cn=Manager,dc=keensoft,dc=es
# Manager password for authenticated searches
ldap.authn.managerPassword=secret

# Search filter used for configurations that require searching for DNs
#ldap.authn.searchFilter=(&(uid={user})(accountState=active))
ldap.authn.searchFilter=(uid={user})

# Search filter used for configurations that require searching for DNs
#ldap.authn.format=uid=%s,ou=Users,dc=example,dc=org
##ldap.authn.format=%s@example.com
ldap.authn.format=uid=%s,ou=People,dc=keensoft,dc=es
ldap.baseDn=ou=People,dc=keensoft,dc=es
ldap.trustedCert=/home/mikel/workspaces/uptc/docker/openldap/assets/pki/cacert.pem

# ServiceRegistryDao Properties
#
ldap.service.url=ldap://ldap
ldap.service.managerDn=cn=Manager,dc=keensoft,dc=es
ldap.service.managerPassword=secret
ldap.service.baseDn=ou=People,dc=keensoft,dc=es
ldap.service.searchFilter=(uid={user})
```
* Se declara el fichero de propiedades en **src/main/webapp/WEB-INF/spring-configuration/propertyFileConfigurer.xml**

```xml
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:p="http://www.springframework.org/schema/p"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">
        <description>
                This file lets CAS know where you've stored the cas.properties file which details some of the configuration options
                that are specific to your environment.  You can specify the location of the file here.  You may wish to place the file outside
                of the Servlet context if you have options that are specific to a tier (i.e. test vs. production) so that the WAR file
                can be moved between tiers without modification.
        </description>

    <context:property-placeholder
        location="/WEB-INF/cas.properties,
                          /WEB-INF/ldap.properties"
        ignore-unresolvable="true"/>
</beans>
```

* Se edita el fichero de configuración principal de CAS **src/main/webapp/WEB-INF/deployerConfigContext.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License.  You may obtain a
    copy of the License at the following location:

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

-->
<!--
| deployerConfigContext.xml centralizes into one file some of the declarative configuration that
| all CAS deployers will need to modify.
|
| This file declares some of the Spring-managed JavaBeans that make up a CAS deployment.
| The beans declared in this file are instantiated at context initialization time by the Spring
| ContextLoaderListener declared in web.xml.  It finds this file because this
| file is among those declared in the context parameter "contextConfigLocation".
|
| By far the most common change you will need to make in this file is to change the last bean
| declaration to replace the default authentication handler with
| one implementing your approach for authenticating usernames and passwords.
+-->

<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:p="http://www.springframework.org/schema/p"
       xmlns:c="http://www.springframework.org/schema/c"
       xmlns:tx="http://www.springframework.org/schema/tx"
       xmlns:util="http://www.springframework.org/schema/util"
       xmlns:sec="http://www.springframework.org/schema/security"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
       http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-3.2.xsd
       http://www.springframework.org/schema/security http://www.springframework.org/schema/security/spring-security-3.2.xsd
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd
       http://www.springframework.org/schema/util http://www.springframework.org/schema/util/spring-util.xsd">
    <context:component-scan base-package="org.jasig.cas" />
    <context:component-scan base-package="org.jasig.cas.authentication" />
    <!--
       | The authentication manager defines security policy for authentication by specifying at a minimum
       | the authentication handlers that will be used to authenticate credential. While the AuthenticationManager
       | interface supports plugging in another implementation, the default PolicyBasedAuthenticationManager should
       | be sufficient in most cases.
       +-->
    <bean id="authenticationManager" class="org.jasig.cas.authentication.PolicyBasedAuthenticationManager">
        <constructor-arg>
            <map>
                <!--
                   | IMPORTANT
                   | Every handler requires a unique name.
                   | If more than one instance of the same handler class is configured, you must explicitly
                   | set its name to something other than its default name (typically the simple class name).
                   -->
                <entry key-ref="proxyAuthenticationHandler" value-ref="proxyPrincipalResolver" />
                <entry key-ref="ldapAuthenticationHandler" value-ref="primaryPrincipalResolver" />
            </map>
        </constructor-arg>

        <!-- Uncomment the metadata populator to allow clearpass to capture and cache the password
             This switch effectively will turn on clearpass.
        <property name="authenticationMetaDataPopulators">
           <util:list>
              <bean class="org.jasig.cas.extension.clearpass.CacheCredentialsMetaDataPopulator"
                    c:credentialCache-ref="encryptedMap" />
           </util:list>
        </property>
        -->

        <!--
           | Defines the security policy around authentication. Some alternative policies that ship with CAS:
           |
           | * NotPreventedAuthenticationPolicy - all credential must either pass or fail authentication
           | * AllAuthenticationPolicy - all presented credential must be authenticated successfully
           | * RequiredHandlerAuthenticationPolicy - specifies a handler that must authenticate its credential to pass
           -->
        <property name="authenticationPolicy">
            <bean class="org.jasig.cas.authentication.AnyAuthenticationPolicy" />
        </property>
    </bean>

    <!-- Required for proxy ticket mechanism. -->
    <bean id="proxyAuthenticationHandler"
          class="org.jasig.cas.authentication.handler.support.HttpBasedServiceCredentialsAuthenticationHandler"
          p:httpClient-ref="httpClient" />

    <!--
        Start the additions for the LDAP authentication here.
        -->

    <bean id="ldapAuthenticationHandler"
          class="org.jasig.cas.authentication.LdapAuthenticationHandler"
          p:principalIdAttribute="uid"
          c:authenticator-ref="authenticator">
        <property name="principalAttributeMap">
            <map>
                <!--
                   | This map provides a simple attribute resolution mechanism.
                   | Keys are LDAP attribute names, values are CAS attribute names.
                   | Use this facility instead of a PrincipalResolver if LDAP is
                   | the only attribute source.
                   -->
                <entry key="uid" value="uid" />
                <entry key="mail" value="mail" />
                <entry key="cn" value="displayName" />
                <entry key="eduPersonPrincipalName" value="eduPersonPrincipalName" />
            </map>
        </property>
    </bean>

    <bean id="authenticator" class="org.ldaptive.auth.Authenticator"
          c:resolver-ref="dnResolver"
          c:handler-ref="authHandler" />

    <bean id="dnResolver" class="org.ldaptive.auth.PooledSearchDnResolver"
          p:baseDn="${ldap.authn.baseDn}"
          p:allowMultipleDns="false"
          p:subtreeSearch="true"
          p:connectionFactory-ref="searchPooledLdapConnectionFactory"
          p:userFilter="${ldap.authn.searchFilter}" />

    <bean id="searchPooledLdapConnectionFactory"
          class="org.ldaptive.pool.PooledConnectionFactory"
          p:connectionPool-ref="searchConnectionPool" />

    <bean id="searchConnectionPool" parent="abstractConnectionPool"
          p:connectionFactory-ref="searchConnectionFactory" />

    <bean id="searchConnectionFactory"
          class="org.ldaptive.DefaultConnectionFactory"
          p:connectionConfig-ref="searchConnectionConfig" />

    <bean id="searchConnectionConfig" parent="abstractConnectionConfig"
          p:connectionInitializer-ref="bindConnectionInitializer" />

    <bean id="bindConnectionInitializer"
          class="org.ldaptive.BindConnectionInitializer"
          p:bindDn="${ldap.authn.managerDn}">
        <property name="bindCredential">
            <bean class="org.ldaptive.Credential"
                  c:password="${ldap.authn.managerPassword}" />
        </property>
    </bean>

    <bean id="abstractConnectionPool" abstract="true"
          class="org.ldaptive.pool.BlockingConnectionPool"
          init-method="initialize"
          p:poolConfig-ref="ldapPoolConfig"
          p:blockWaitTime="${ldap.pool.blockWaitTime}"
          p:validator-ref="searchValidator"
          p:pruneStrategy-ref="pruneStrategy" />

    <bean id="abstractConnectionConfig" abstract="true"
          class="org.ldaptive.ConnectionConfig"
          p:ldapUrl="${ldap.url}"
          p:connectTimeout="${ldap.connectTimeout}"
          p:useStartTLS="${ldap.useStartTLS}"
          p:sslConfig-ref="sslConfig" />

    <bean id="ldapPoolConfig" class="org.ldaptive.pool.PoolConfig"
          p:minPoolSize="${ldap.pool.minSize}"
          p:maxPoolSize="${ldap.pool.maxSize}"
          p:validateOnCheckOut="${ldap.pool.validateOnCheckout}"
          p:validatePeriodically="${ldap.pool.validatePeriodically}"
          p:validatePeriod="${ldap.pool.validatePeriod}" />

    <bean id="sslConfig" class="org.ldaptive.ssl.SslConfig">
        <property name="credentialConfig">
            <bean class="org.ldaptive.ssl.X509CredentialConfig"
                  p:trustCertificates="${ldap.trustedCert}" />
        </property>
    </bean>

    <bean id="pruneStrategy" class="org.ldaptive.pool.IdlePruneStrategy"
          p:prunePeriod="${ldap.pool.prunePeriod}"
          p:idleTime="${ldap.pool.idleTime}" />

    <bean id="searchValidator" class="org.ldaptive.pool.SearchValidator" />

    <bean id="authHandler" class="org.ldaptive.auth.PooledBindAuthenticationHandler"
          p:connectionFactory-ref="bindPooledLdapConnectionFactory" />

    <bean id="bindPooledLdapConnectionFactory"
          class="org.ldaptive.pool.PooledConnectionFactory"
          p:connectionPool-ref="bindConnectionPool" />

    <bean id="bindConnectionPool" parent="abstractConnectionPool"
          p:connectionFactory-ref="bindConnectionFactory" />

    <bean id="bindConnectionFactory"
          class="org.ldaptive.DefaultConnectionFactory"
          p:connectionConfig-ref="bindConnectionConfig" />

    <bean id="bindConnectionConfig" parent="abstractConnectionConfig" />

    <!--
        End of LDAP authentication insertions
        -->

    <!-- Required for proxy ticket mechanism -->
    <bean id="proxyPrincipalResolver"
          class="org.jasig.cas.authentication.principal.BasicPrincipalResolver" />

    <!--
       | Resolves a principal from a credential using an attribute repository that is configured to resolve
       | against a deployer-specific store (e.g. LDAP).
       -->
    <bean id="primaryPrincipalResolver"
          class="org.jasig.cas.authentication.principal.PersonDirectoryPrincipalResolver" >
        <property name="attributeRepository" ref="attributeRepository" />
    </bean>

    <!--
    Bean that defines the attributes that a service may return.  This example uses the Stub/Mock version.  A real implementation
    may go against a database or LDAP server.  The id should remain "attributeRepository" though.
    +-->
    <!--
    <bean id="attributeRepository" class="org.jasig.services.persondir.support.StubPersonAttributeDao"
            p:backingMap-ref="attrRepoBackingMap" />

    <util:map id="attrRepoBackingMap">
        <entry key="uid" value="uid" />
    </util:map>
    -->
    <bean id="attributeRepository"
        class="org.jasig.cas.persondir.LdapPersonAttributeDao"
        p:baseDN="${ldap.authn.baseDn}"
        p:searchFilter="${ldap.authn.searchFilter}"
        p:searchControls-ref="searchControls"
        p:connectionFactory-ref="searchPooledLdapConnectionFactory"
        p:queryAttributeMapping-ref="queryAttributeMap"
        p:resultAttributeMapping-ref="resultAttributeMap" />


    <util:map id="queryAttributeMap">
        <entry key="user" value="uid" />
    </util:map>

    <util:map id="resultAttributeMap">
        <entry value="Name" key="cn" />
        <entry value="memberOf" key="memberOf" />
    </util:map>

    <bean id="searchControls"
          class="javax.naming.directory.SearchControls"
          p:searchScope="2" />


    <bean id="serviceRegistryDao" class="org.jasig.cas.services.InMemoryServiceRegistryDaoImpl">
		<property name="registeredServices">
			<list>
				<bean class="org.jasig.cas.services.RegexRegisteredService">
					<property name="id" value="0" />
					<property name="name" value="HTTP and IMAP" />
					<property name="description" value="Allows HTTP(S) and IMAP(S) protocols" />
					<property name="serviceId" value="^(https?|imaps?)://.*" />
					<property name="evaluationOrder" value="10000001" />
					<property name="allowedAttributes">
						<list>
							<value>Name</value>
							<value>memberOf</value>
						</list>
					</property>
				</bean>
			</list>
		</property>
	</bean>

    <!--
        Service registry over LDAP additions.  This is where all the stuff for the service registry needs to be defined.

        The first set of stuff should be used to set up the LDAP connection Pool.
        -->
    <!--
    <bean id="serviceRegistryDao"
          class="org.jasig.cas.adaptors.ldap.services.LdapServiceRegistryDao"
          p:connectionFactory-ref="servicePooledLdapConnectionFactory"
          p:searchRequest-ref="searchRequest"
          p:ldapServiceMapper-ref="ldapMapper" />

    <bean id="servicePooledLdapConnectionFactory"
          class="org.ldaptive.pool.PooledConnectionFactory"
          p:connectionPool-ref="serviceConnectionPool" />

    <bean id="serviceConnectionPool" parent="abstractConnectionPool"
          p:connectionFactory-ref="serviceConnectionFactory" />

    <bean id="serviceConnectionFactory"
          class="org.ldaptive.DefaultConnectionFactory"
          p:connectionConfig-ref="serviceConnectionConfig" />

    <bean id="serviceConnectionConfig" parent="svcAbstractConnectionConfig"
          p:connectionInitializer-ref="serviceConnectionInitializer" />

    <bean id="svcAbstractConnectionConfig" abstract="true"
          class="org.ldaptive.ConnectionConfig"
          p:ldapUrl="${ldap.service.url}"
          p:connectTimeout="${ldap.connectTimeout}"
          p:useStartTLS="${ldap.useStartTLS}"
          p:sslConfig-ref="sslConfig" />

    <bean id="serviceConnectionInitializer"
          class="org.ldaptive.BindConnectionInitializer"
          p:bindDn="${ldap.service.managerDn}">
        <property name="bindCredential">
            <bean class="org.ldaptive.Credential"
                  c:password="${ldap.service.managerPassword}" />
        </property>
    </bean>

    <bean id="searchRequest"
          class="org.ldaptive.SearchRequest"
          p:baseDn="${ldap.service.baseDn}"
          p:searchFilter="${ldap.service.searchFilter}" />

    <bean id="ldapMapper"
          class="org.jasig.cas.adaptors.ldap.services.DefaultLdapServiceMapper"/>
    -->
    <!--
        End of Serivce registry additions.
        -->

    <bean id="auditTrailManager" class="com.github.inspektr.audit.support.Slf4jLoggingAuditTrailManager" />

    <bean id="healthCheckMonitor" class="org.jasig.cas.monitor.HealthCheckMonitor" p:monitors-ref="monitorsList" />

    <util:list id="monitorsList">
      <bean class="org.jasig.cas.monitor.MemoryMonitor" p:freeMemoryWarnThreshold="10" />
      <!--
        NOTE
        The following ticket registries support SessionMonitor:
          * DefaultTicketRegistry
          * JpaTicketRegistry
        Remove this monitor if you use an unsupported registry.
      -->
      <!--
      <bean class="org.jasig.cas.monitor.SessionMonitor"
          p:ticketRegistry-ref="ticketRegistry"
          p:serviceTicketCountWarnThreshold="5000"
          p:sessionCountWarnThreshold="100000" />
          -->
    </util:list>
</beans>
```

* Se compila la aplicación y se copia dentro de la imagen docker cas

```
$ mvn clean package -Dmaven.test.failure.ignore=true
$ cp target/cas.war $DOCKER_HOME/cas/assets
```

## MNT-15795 aka cas-slingshotSSOConnector

* Es necesario instalar el parche aportado por Ian Wrigth para que funcione el SSO. Este artefacto se ha denominado cas-slingshotSSOConnector-share (igual debería de haberse llamado mnt-15795-share)

```
$ git clone http://bitbucket.oficina.keensoft.es:7990/scm/upcalf/alfresco.git
$ cd cas-slingshotSSOConnector-share
$ mvn clean package
$ cp target/cas-slingshotSSOConnector-share-1.0-SNAPSHOT.amp $DOCKER_HOME/share/assets/amps_share
```

## Arrancar el entorno docker

### Primer arranque

```
$ docker-compose build
$ docker-compose up -d
$ docker-compose up -d libreoffice
```

### Sucesivos aranques

```
$ docker-compose up -d
$ docker-compose stop
```

### Realizar cambios

```
$ docker-compose stop
$ docker-compose rm -vf (opcional, sólo si queremos empezar de 0 con el repo etc)

(hacemos los cambios que hagan falta)

$ docker-compose build
$ docker-compose up -d
$ docker-compose up -d libreoffice (sólo si hemos ejecutado docker-compse rm -vf ó es el primer arranque)
```

## Script update_artifacts.sh

Se ha creado un sencillo script para ayudar en el redespliegue los dos artefactos requeridos.

```
#!/bin/bash
#

ARTIFACTS_HOME="/home/mikel/workspaces/uptc/alfresco"
CAS_SERVER_WEBAPP_HOME="$ARTIFACTS_HOME/cas-server-webapp"
SHARE_CONNECTOR_PATCH="$ARTIFACTS_HOME/cas-slingshotSSOConnector-share"

pushd $CAS_SERVER_WEBAPP_HOME
mvn clean package "-Dmaven.test.failure.ignore=true"
popd
cp $CAS_SERVER_WEBAPP_HOME/target/cas.war cas/assets

pushd $SHARE_CONNECTOR_PATCH
mvn clean package
popd
cp $SHARE_CONNECTOR_PATCH/target/cas-slingshotSSOConnector-share-1.0-SNAPSHOT.amp share/assets/amps_share
```


## Pruebas

### Requisitos

Incluir la siguiente entrada en nuestro /etc/hosts, cambiando la IP del ejemplo por la IP adecuada en nuestro caso

```
192.168.1.33	alfuptc.keensoft.es shruptc.keensoft.es cas
```

### Secuencia de funcionamiento del SSO

1. Escribimos la siguiente URL en el navegador

```
https://shruptc.keensoft/share

```

2. Nos redirige a https://cas:8443/cas/login
3. Introducimos las credenciales de alguno de los usuarios existentes en el LDAP
4. CAS nos vuelve a redirigir de vuelta a Share con el ticket de sesión
4. El filtro SSO del Share analiza y extrae la información de usuario del ticket CAS
5. El filtro SSO del Share autentica al usuario informando a Alfresco del username a través de la cabecera configurada "X-Alfresco-Remote-User", esta cabecera solo tiene sentido entre Alfresco y Share
6. La autenticación externa en el repo establece la sesión de usuario y el Share a su vez sirve el home del usuario

## Notas

* Hay que asegurar que el Tomcat de Alfresco no reciba peticiones que no vengan de Apache HTTPD (en localhost)

La configuración de la autenticación externa implica que Alfresco confía en cualquier petición que contenga la cabecera "X-Alfresco-Remote-User"

```
curl -X GET -L -H "X-Alfresco-Remote-User": admin" http://localhost:8080/alfresco/ | less
```

* Hay que considerar el SLO (Single Log Out) como una mejora ya que parece que es un problema habitual de CAS el hecho de dejar sesiones "abiertas"

## OpenLdap

El esquema de LDAP es muy simple, tan sólo se crean dos usuarios para el propósito de las pruebas

* admin / secret
* mikel / mikel

Si se require, se puede modifcar el esquema antes de lanzar el build editando el siguiente fichero para incluir grupos y otros usuarios. Se tiene que respetar el dominio **dc=keensoft,dc=es** o adaptar los demás LDIFS de la carpeta ***openldap/assets***

* openldap/assets/basedomain.ldif


## Referencias

* [CAS 4.0.x Docs](https://apereo.github.io/cas/4.0.x/index.html)
* [MNT-15795](https://issues.alfresco.com/jira/browse/MNT-15795)
* [Blog de Ian Wright (CAS en general)](http://tech.wrighting.org/category/cas/)
* [Blog de Ian Wright (CAS + LDAP)](http://tech.wrighting.org/2013/05/cas-openldap-and-groups/)
* [Ejemplo de configuración CAS 4.0.x + OpenLDAP](http://www-public.tem-tsp.eu/~procacci/dok/lib/exe/fetch.php?media=docpublic:systemes:ssocas:deployerconfigcontext.xml)
* [Documentación de Alfresco 5.0.d sobre CAS y mod_auth_cas para Alfresco Share SSO ](http://docs.alfresco.com/community5.0/concepts/alf-modauthcas-home.html)
* [Ejemplo de configuración CAS 4.0.x + OpenLDAP + AttributeRepository](https://groups.google.com/forum/#!topic/jasig-cas-user/2G85KtZTL1c)
