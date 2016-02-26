# Alfresco Docker template use example

This example makes use of [keensoft alfresco-docker-template](https://hub.docker.com/r/keensoft/alfresco-docker-template/) to run latest Alfresco Community Edition distribution on a Docker container

## Manual Startup

* First thing we need is a PostgreSQL database to connect to, if you haven't one already, just run it with docker

	docker run --name postgres -e POSTGRES_DB=alfresco -e POSTGRES_USER=alfresco -e POSTGRES_PASSWORD=alfresco -d postgres

* Second, we need a LibreOffice instance that Alfresco will use as a [Trasnformation server](https://hub.docker.com/r/keensoft/libreoffice/) (in TCP 8100 by default)

	docker run --name libreoffice -d keensoft/libreoffice:latest

* Third, build this docker image

	docker build -t \(your_tag\) .

* And lastly run the dockerized Alfresco 

	docker run --name \(your_name\) --link postgres:postgres --link libreoffice:libreoffice -p 8080:8080 -d \(your_tag\)
	

## Docker Compose

* You can also find a [docker-compose](https://docs.docker.com/compose/compose-file/) configuration file, which uses "depends-on" directive (Compose file version 2) to ensure components follow desired order starting and stopping services.

	docker-compose up -d 


## Access 

	http://localhost:8080/share (admin/admin)


