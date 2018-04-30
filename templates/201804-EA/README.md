# Alfresco Docker 201804-EA

*Production-ready* composition based in official [Docker Composition](https://github.com/Alfresco/acs-community-deployment/tree/master/docker-compose) provided by Alfresco

Containers

* alfresco 6.0.5-ea 
* share 6.0.a
* postgres 10.1
* solr6 (alfresco-search-services-1.1.1)

Components

* AOS 1.2.0-RC2
* api-explorer 5.2.2

Addons

* JavaScript Console 0.6.0
* OOTB Support Tools 1.1.0.0-SNAPSHOT

# How to use

Before starting to use this project, three Named Docker Volumes must be available

```bash
$ docker volume list
local               alf-repo-data
local               postgres-data
local               solr-data
```

You can create them by using following sentences:

```bash
$ docker volume create alf-repo-data
$ docker volume create postgres-data
$ docker volume create solr-data
```

## Start

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

Logs

```bash
$ docker-compose logs -f
```

## Access

User: admin
Password: admin

```
https://localhost/share
https://localhost/alfresco
https://localhost/solr
https://localhost/api-explorer
```

## Further configuration

### Deploying additional Addons

You can copy additional Alfresco addons to following paths

```
alfresco/target/amps
alfresco/target/jars
share/target/amps_share
share/target/jars
```

After `rebuild` the image, they will be available

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

Default SSL certificates are *self-generated*. You can include your certificates at `httpd/assets` folder