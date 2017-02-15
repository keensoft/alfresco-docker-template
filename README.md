# alfresco-docker-template

*  201701-GA, latest [201701-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201701-GA/Dockerfile)
*  201612-GA [201612-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201612-GA/Dockerfile)
*  201605-GA [201605-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201605-GA/Dockerfile)
*  201604-GA [201604-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201604-GA/Dockerfile)
*  201602-GA [201602-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201602-GA/Dockerfile)
*  5.0.d [5.0.d/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/5.0.d/Dockerfile)
*  4.2.c [4.2.c/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/4.2.c/Dockerfile)

## Description

This template can be used to deploy custom Alfresco Community installations starting your Dockerfiles with the following statement

~~~~~
FROM keensoft/alfresco-docker-template:latest
~~~~~

[We](http://keensoft.es/) are using this templated "dockerized Alfresco" idea at the moment in several ways in our day to day Document Management solutions development lifecycle, like for example reproducing issues and so on.

## Stack

*   [Centos 7](https://hub.docker.com/_/centos/)
*   [Oracle SUN JDK 8u121](http://www.oracle.com/technetwork/java/javaseproducts/downloads/index.html)
*   [Apache Tomcat 7.0.69](https://www.apache.org/dist/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz)

## Templates in action

### [4.2.c](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/4.2.c)

This example deploys Alfresco 4.2.c with Alfresco, Share and Solr4 within the same tomcat instance. Note that in this version alfresco-solr was distributed in a separate ZIP so deployment is a bit different

### [5.0.d](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/5.0.d)

This example deploys Alfresco 5.0.d running with Solr4 node and libreoffice 4.4.5 on separate containers


### 201602-GA

### 201604-GA

### [201605-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201605-GA)

This examples shows how to make use of Ian Wrigth's Alfresco-CAS integration with support for SSO and SLO

### 201612-GA

This examples uses 201612-GA template to deploy Alfresco, Share and Solr4 standalone, along with the api-explorer

### [201701-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201701-GA)

This example uses alfresco-docker-template:201701-GA to deploy Alfresco 5.2.0 running with Solr6 node and libreoffice 5.2.1
