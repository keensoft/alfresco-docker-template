# alfresco-docker-template

## TAGS

*  201702-GA, latest [201702-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201701-GA/Dockerfile) 
*  201701-GA [201701-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201701-GA/Dockerfile)
*  201612-GA [201612-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201612-GA/Dockerfile)
*  201605-GA [201605-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201605-GA/Dockerfile)
*  201604-GA [201604-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201604-GA/Dockerfile)
*  201602-GA [201602-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201602-GA/Dockerfile)
*  5.0.d [5.0.d/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/5.0.d/Dockerfile)
*  4.2.c [4.2.c/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/4.2.c/Dockerfile)

## Description

This template can be used to deploy custom Alfresco Community installations starting your Dockerfiles with the following statement

~~~~~
FROM keensoft/alfresco-docker-template:201702-GA
~~~~~

[We](http://keensoft.es/) are using this templated "dockerized Alfresco" idea at the moment in several ways in our day to day Document Management solutions development lifecycle, like integration tests or reproducing issues and so on.

## Stack

*   [Centos 7](https://hub.docker.com/_/centos/)
*   [Oracle SUN JDK 8u121](http://www.oracle.com/technetwork/java/javaseproducts/downloads/index.html)
*   [Apache Tomcat 7.0.69](https://www.apache.org/dist/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz)


## Templates in action

### [4.2.c](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/4.2.c)

Containers

* alfresco, share & solr4 4.2.c
* postgres 9.4
* libreoffice 5.1.2 

### [5.0.d](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/5.0.d)

Containers

* alfresco & share 5.0.d
* solr4 5.0.d
* postgres 9.4
* libreoffice 5.1.2

### [201605-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201605-GA)

Containers

* alfresco 5.1.g
* share 5.1.f
* solr4 5.1.g
* postgres 9.4
* httpd 2.4 
* libreoffice
* cas 4.1
* openldap

In this particular example Share is configured to authenticate against a CAS Server using Ian Wrigth's [Alfresco-CAS integration](https://github.com/wrighting/alfresco-cas) project which can be used to integrate Alfresco and CAS support for SSO and SLO

### [201612-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201612-GA)

Containers

* alfresco 5.2.d, share 5.2.c & api-explorer 5.2.0
* httpd 2.4 (reverse proxy on port 80) 
* postgres 9.4 
* libreoffice 5.1.2
* solr6 (alfresco-search-services-1.0-EA)

### [201701-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201701-GA)

Containers

* alfresco 5.2.e, share 5.2.d & api-explorer 5.2.0
* httpd 2.4 (reverse proxy on port 80)
* postgres 9.4  
* libreoffice 5.1.2
* solr6 (alfresco-search-services-1.0.b)

### [201702-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201702-GA)

Containers

* alfresco 5.2.f & api-explorer 5.2.0
* share 5.2.e
* httpd 2.4 (reverse proxy on port 80)
* postgres 9.4
* libreoffice 5.1.2
* solr6 (alfresco-search-services-1.0.0)
* swagger-editor 

