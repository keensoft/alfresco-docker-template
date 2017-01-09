# alfresco-docker-template

*  201612-GA, latest [201612-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201612-GA/alfresco/Dockerfile)
*  201605-GA [201605-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201605-GA/Dockerfile)
*  201604-GA [201604-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201604-GA/Dockerfile)
*  201602-GA [201602-GA/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/201602-GA/Dockerfile)
*  5.0.d [5.0.d/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/5.0.d/Dockerfile)
*  4.2.c [4.2.c/Dockerfile](https://github.com/keensoft/alfresco-docker-template/blob/master/4.2.c/Dockerfile)

### Description

This template can be used to deploy custom Alfresco Community installations starting your Dockerfiles with
the following statement

	FROM keensoft/alfresco-docker-template:latest

There is full example at the bottom i did to help me exposing this [talk](http://beecon.buzz/assets/data/files/20160125042/BeeCon2016_Running_Alfresco_Under_Docker.pdf) on this year's [BeeCon2016](http://beecon.buzz). It was a very enriching experience to meet so many community heroes. 

Obviously, there are allways parts of your talk that you would like to have done better, in me case, the very good cuestions I get after the session. Let's try to balance that lack of a better english knowledge :)

[We](http://keensoft.es) are using this templated "dockerized Alfresco" idea at the moment in several ways in our day to day Document Management solutions development lifecycle, like for example reproducing issues and so on. 

**But**, it is not intended to be used as a local "instance" for development process, you got [Alfresco Maven SDK](http://docs.alfresco.com/5.1/concepts/alfresco-sdk-intro.html) for that, it may be some day but there are some considerations to address; [Docker Volumes](https://docs.docker.com/engine/tutorials/dockervolumes/) handling manly. 

* One thing to consider is that containers can be seen as a photograp of your application at one time, you can't go backwards or forwards on time. Well, with containers you can realy go forwards, but is not what you may expect if you are not familiar with containers.

To go fordward you could do something of these

* Do changes on your project (Dockerfile, assets, etc) and rebuild your containers (prefered way for me), then commit those changes and share the new state of the application

* Get the container's shell and do your changes on hot-deploying stuff, you lost consistency with your Dockerfile

```
docker exec -it <your_running_container_name> bash
```
* Docker Machine has the "scp" command, i haven't try this one
	
* The [Tomcat image](https://hub.docker.com/r/keensoft/centos7-java8-tomcat7/) this template is based on has the manager app on it with (manager / manager) credentials. There you can redeploy your war file, **as you can't stop** the main process of a container or it will just stop the container itself. Again you lost consistency with your Dockerfile

* You can do [docker commit](https://docs.docker.com/engine/reference/commandline/commit/) and create a new image with your changes, but you lost consistency with your Dockerfiles.

### Stack

*   [Centos 7](https://hub.docker.com/_/centos/)
*   [Oracle SUN JDK 8u91](http://www.oracle.com/technetwork/java/javaseproducts/downloads/index.html)
*   [Apache Tomcat 7.0.69](https://www.apache.org/dist/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz)

### Complete example

You can find [here](https://github.com/keensoft/alfresco-docker-template/tree/master/example) an example illustrating the use of this tamplate to build custom Alfresco installations. In this particular example Alfresco, Alfresco Share and Solr4 run all in the same Tomcat instance, but more complex component distributions could be done. The only particularity of this example is that it configures Solr4 and Alfresco comunication to be plain HTTP and that the Javascript console Addon is installed.
