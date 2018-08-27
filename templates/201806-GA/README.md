# Alfresco Docker 201806-GA

*Production-ready* composition based in official [Docker Composition](https://github.com/Alfresco/acs-community-deployment/tree/master/docker-compose) provided by Alfresco.

## Containers

* alfresco 6.0.7-ga 
* share 6.0.b
* postgres 10.1
* solr6 (alfresco-search-services-1.1.1)

## Components

* AOS 1.2.0
* api-explorer 6.0.7-ga

# How to use this composition

Data wil be persisted automatically in `data` folder. Once launched, Docker will create three subfolders for following services:

* `alf-repo-data` for Content Store
* `postgres-data` for Database
* `solr-data` for Indexes

For Linux hosts, set `solr-data` folder permissions to user with UID 1001, as `alfresco-search-services` is using an container user named `solr` with UID 1001.

## Start Docker

Start docker and check the ports are correctly bound.

```bash
$ docker-compose up -d
$ docker ps
docker_httpd     80/tcp, 
                 0.0.0.0:443->443/tcp
docker_alfresco  1137-1139/tcp, 
                 1445/tcp, 8080/tcp, 
                 0.0.0.0:143->1143/tcp, 
                 0.0.0.0:21->2121/tcp, 
                 0.0.0.0:25->2525/tcp
postgres:10.1    0.0.0.0:5432->5432/tcp
alfresco/alfresco-search-services:1.1.1   8983/tcp
docker_share     8080/tcp
```

### Viewing System Logs

You can view the system logs by issuing the following.

```bash
$ docker-compose logs -f
```

## Access

Use the following username/password combination to login.

 - User: admin
 - Password: admin

Alfresco and related web applications can be accessed from the below URIs when the servers have started.

```
https://localhost/share
https://localhost/alfresco
https://localhost/solr
https://localhost/api-explorer
```

## Further configuration

### Deploying additional Addons

You can copy additional Alfresco addons to following paths.

```
alfresco/modules/amps
alfresco/modules/jars
share/modules/amps_share
share/modules/jars
```

After you `rebuild` the image, they will be available within the Alfresco instance.

### Adding configuration to repository

You can set additional properties to repository configuration by including these lines in file `alfresco/Dockerfile`

```bash
# Add services configuration to alfresco-global.properties
RUN echo -e '\n\
property=value\n\
\n\
' >> /usr/local/tomcat/shared/classes/alfresco-global.properties
```

### Using real SSL certificates

Default SSL certificates are *self-generated*. You can include your certificates at `https/assets` folder

### Using plain HTTP

You can use plain HTTP by using `docker-compose-http.yml` Docker Compose

```
$ docker-compose -f docker-compose-http.yml` up
```

With this option, following services are available:

```
http://localhost/share
http://localhost/alfresco
http://localhost/solr
http://localhost/api-explorer
```


