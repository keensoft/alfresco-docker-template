# alfresco-docker-template

## TAGS

*  201804-EA, latest [201804-EA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201804-EA__alpine/Dockerfile)
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

[We](http://keensoft.es/) are using this templated "dockerized Alfresco" idea at the moment in several ways in our day to day Content Services solutions development lifecycle, development, integration tests or reproducing issues and so on.

## Stack for 201804-EA

* [Tomcat 7-jre8 alpine]

## Stack previous to 201804-EA

*   [Centos 7](https://hub.docker.com/_/centos/)
*   [OpenJDK Runtime Environment (build 1.8.0_131-b12)](http://openjdk.java.net/install/index.html)
*   [Apache Tomcat 7.0.59](https://www.apache.org/dist/tomcat/tomcat-7/v7.0.59/bin/apache-tomcat-7.0.59.tar.gz)

Base images (centos7-openjdk8 and centos7-openjdk8-tomcat7) are located [here](https://github.com/keensoft/alfresco-docker-template/blob/master/base)

## Templates in action

Following examples illustrate one way of using this Alfresco docker image template. 

### [201804-EA](https://github.com/keensoft/alfresco-docker-template/tree/master/201708-EA__alpine)

* Alfresco Content Services 6.0.5-ea
* Share 6.0.a
* Postgres 10.1
* Alfresco Search Services 1.1.1
* Alfresco PDF Renderer 1.0
* Alfresco Libreoffice 1.0
* Alfresco Imagemagick 1.0

### [201707-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201707-GA)

Containers

* Alfresco 5.2.g 
* Share 5.2.f
* Postgres 9.4
* Libreoffice 5.1.2
* Solr6 (alfresco-search-services-1.1.0)
* Api-explorer 5.2.0

### [201704-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201704-GA)

Containers

* Alfresco 5.2.f & api-explorer 5.2.0
* Share 5.2.e
* Nginx 1.12.1 (reverse proxy on port 80/443)
* Postgres 9.4
* Libreoffice 5.1.2
* Solr6 (alfresco-search-services-1.0.0)

### [201702-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201702-GA)

Containers

* Alfresco 5.2.f & api-explorer 5.2.0
* Share 5.2.e
* Httpd 2.4 (reverse proxy on port 80)
* Postgres 9.4
* Libreoffice 5.1.2
* Solr6 (alfresco-search-services-1.0.0)
* Swagger-editor 

### [201701-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201701-GA)

Containers

* Alfresco 5.2.e, share 5.2.d & api-explorer 5.2.0
* Httpd 2.4 (reverse proxy on port 80)
* Postgres 9.4  
* Libreoffice 5.1.2
* Solr6 (alfresco-search-services-1.0.b)

### [201612-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201612-GA)

Containers

* Alfresco 5.2.d, share 5.2.c & api-explorer 5.2.0
* Httpd 2.4 (reverse proxy on port 80) 
* Postgres 9.4 
* Libreoffice 5.1.2
* Solr6 (alfresco-search-services-1.0-EA)

### [201605-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201605-GA)

Containers

* Alfresco 5.1.g
* Share 5.1.f
* Solr4 5.1.g
* Postgres 9.4
* Httpd 2.4 
* Libreoffice
* Cas 4.1
* Openldap

In this particular example Share is configured to authenticate against a CAS Server using Ian Wrigth's [Alfresco-CAS integration](https://github.com/wrighting/alfresco-cas) project which can be used to integrate Alfresco and CAS support for SSO and SLO

### [201604-GA](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/201604-GA)

* Alfresco 5.1.f
* Nginx 1.12
* Postgres 9.4
* Share 5.1.f
* Solr4 5.1.f

### [5.0.d](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/5.0.d)

Containers

* Alfresco & share 5.0.d
* Solr4 5.0.d
* Postgres 9.4
* Libreoffice 5.1.2


### [4.2.c](https://github.com/keensoft/alfresco-docker-template/tree/master/templates/4.2.c)

Containers

* Alfresco, share & solr4 4.2.c
* Postgres 9.4
* Libreoffice 5.1.2 

## How to use template examples

### Start

~~~~~
$ docker-compose up

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

Check ports on each template example with `docker-compose ps`. This is just a template to get you up and running quickly. Always check [reference](https://docs.docker.com/compose/compose-file/) and make your adjustments as appropiate 