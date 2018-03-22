# alfresco-docker-template

## TAGS

*  201707-GA, latest [201707-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201707-GA/Dockerfile) 
*  201704-GA [201704-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201704-GA/Dockerfile) 
*  201702-GA [201702-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201702-GA/Dockerfile) 
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
FROM keensoft/alfresco-docker-template:201707-GA
~~~~~

[We](http://keensoft.es/) are using this templated "dockerized Alfresco" idea at the moment in several ways in our day to day Document Management solutions development lifecycle, like integration tests or reproducing issues and so on.

## Stack

*   [Centos 7](https://hub.docker.com/_/centos/)
*   [OpenJDK Runtime Environment (build 1.8.0_131-b12)](http://openjdk.java.net/install/index.html)
*   [Apache Tomcat 7.0.59](https://www.apache.org/dist/tomcat/tomcat-7/v7.0.59/bin/apache-tomcat-7.0.59.tar.gz)

Base images (centos7-openjdk8 and centos7-openjdk8-tomcat7) are located [here](https://github.com/keensoft/alfresco-docker-template/blob/master/base)

## Templates in action

Following examples illustrate one way of using this Alfresco docker image template. 

### [201707-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201707-GA)

Containers

* alfresco 5.2.g 
* share 5.2.f
* postgres 9.4
* libreoffice 5.1.2
* solr6 (alfresco-search-services-1.1.0)
* api-explorer 5.2.0

### [201704-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201704-GA)

Containers

* alfresco 5.2.f & api-explorer 5.2.0
* share 5.2.e
* nginx 1.12.1 (reverse proxy on port 80/443)
* postgres 9.4
* libreoffice 5.1.2
* solr6 (alfresco-search-services-1.0.0)

### [201702-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201702-GA)

Containers

* alfresco 5.2.f & api-explorer 5.2.0
* share 5.2.e
* httpd 2.4 (reverse proxy on port 80)
* postgres 9.4
* libreoffice 5.1.2
* solr6 (alfresco-search-services-1.0.0)
* swagger-editor 

### [201701-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201701-GA)

Containers

* alfresco 5.2.e, share 5.2.d & api-explorer 5.2.0
* httpd 2.4 (reverse proxy on port 80)
* postgres 9.4  
* libreoffice 5.1.2
* solr6 (alfresco-search-services-1.0.b)

### [201612-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201612-GA)

Containers

* alfresco 5.2.d, share 5.2.c & api-explorer 5.2.0
* httpd 2.4 (reverse proxy on port 80) 
* postgres 9.4 
* libreoffice 5.1.2
* solr6 (alfresco-search-services-1.0-EA)

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

### [201604-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201604-GA)

* alfresco 5.1.f
* nginx 1.12
* postgres 9.4
* share 5.1.f
* solr4 5.1.f

### [5.0.d](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/5.0.d)

Containers

* alfresco & share 5.0.d
* solr4 5.0.d
* postgres 9.4
* libreoffice 5.1.2


### [4.2.c](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/4.2.c)

Containers

* alfresco, share & solr4 4.2.c
* postgres 9.4
* libreoffice 5.1.2 

## How to use template examples

### Start

~~~~~
$ docker-compose up -d
$ docker-compose ps

        Name                       Command               State                     Ports                    
------------------------------------------------------------------------------------------------------------
201707ga_alfresco_1      ./wait-for-postgres.sh db  ...   Up      8009/tcp, 8080/tcp, 0.0.0.0:9999->9999/tcp 
201707ga_db_1            docker-entrypoint.sh postgres    Up      5432/tcp                                   
201707ga_libreoffice_1   /opt/libreoffice/startoo.sh      Up      8997/tcp                                   
201707ga_nginx_1         nginx -g daemon off;             Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp   
201707ga_share_1         catalina.sh run                  Up      8009/tcp, 0.0.0.0:8080->8080/tcp           
201707ga_solr6_1         ./run.sh run                     Up      0.0.0.0:8983->8983/tcp            
~~~~~

### Access

User: admin
Password: admin

~~~~~
http://localhost/share
http://localhost/alfresco
http://localhost:8983/solr
~~~~~