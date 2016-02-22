# Alfresco Docker template use example

This example makes use of [keensoft alfresco-docker-template](https://hub.docker.com/r/keensoft/alfresco-docker-template/) to run latest Alfresco Community Edition distribution on a Docker container

* 1. First thing we need is a PostgreSQL database to connect to

	docker run --name postgres -e POSTGRES_DB=alfresco -e POSTGRES_USER=alfresco -e POSTGRES_PASSWORD=alfresco -d postgres

* 2. Also we need a LibreOffice instance that Alfresco will use as a Trasnformation server

	docker run --name libreoffice -d keensoft/libreoffice:latest

* 3. Build this new Docker image

	docker build -t <your_tag> .

* 4. Finally, run the dockerized Alfresco 

	docker run --name <your_name> --link postgres:postgres --link libreoffice:libreoffice -d <your_tag>
	docker logs -f <your_name>


