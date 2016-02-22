# alfresco-docker-template

*  5.1.e (201602-GA) , latest [5.1.e/DockerFile](https://github.com/keensoft/alfresco-docker-template/blob/master/5.1.e/Dockerfile)
*  5.0.d [5.0.d/DockerFile](https://github.com/keensoft/alfresco-docker-template/blob/master/5.0.d/Dockerfile)
*  4.2.c [4.2.c/DockerFile](https://github.com/keensoft/alfresco-docker-template/blob/master/4.2.c/Dockerfile)

### Description

This template can be used to deploy custom Alfresco Community installations starting your Dockerfiles with
the following statement

	FROM keensoft/alfresco-docker-template:latest

### Stack

*   [Centos 7](https://hub.docker.com/_/centos/)
*   [Oracle SUN JDK 8.0.45](http://www.oracle.com/technetwork/java/javaseproducts/downloads/index.html)
*   [Apache Tomcat 7.0.67](https://www.apache.org/dist/tomcat/tomcat-7/v7.0.67/bin/apache-tomcat-7.0.67.tar.gz)

### Complete example

You can find [here](https://github.com/keensoft/alfresco-docker-template/tree/master/example) an example illustrating the use of this tamplate to build custom Alfresco installations. In this particular example Alfresco, Alfresco Share and Solr4 run all in the same Tomcat instance, but more complex component distributions could be done. The only particularity of this example is that it configures Solr4 and Alfresco comunication to be plain HTTP and that the Javascript console Addon is installed.
