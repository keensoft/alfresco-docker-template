# Alfresco Docker 201804-EA

*Production-ready* composition based in official [Docker Composition](https://github.com/Alfresco/acs-community-deployment/tree/master/docker-compose) provided by Alfresco.

#### Containers

* alfresco 6.0.5-ea 
* share 6.0.a
* postgres 10.1
* solr6 (alfresco-search-services-1.1.1)

#### Components

* AOS 1.2.0-RC2
* api-explorer 5.2.2

# How to use this composition

You can setup Alfresco using either the included Makefile or by using manual commands.

1. Automatic

    Use the Makefile, run `make` on the checked out project root to automatically create the volumes and start docker as a daemon.

2. Manual
	
	See below.
	
## Setting up manually	


Before starting to use this project, three Named Docker Volumes must be available

### Ensure volmes are available

Check for the existance of volumes by issuing `docker volume list`.

```bash
$ docker volume list
local               alf-repo-data
local               postgres-data
local               solr-data
```

### Create Volumes

You can create the volumes by using following commands:

```bash
$ docker volume create alf-repo-data
$ docker volume create postgres-data
$ docker volume create solr-data
```

### Start Docker

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
alfresco/target/amps
alfresco/target/jars
share/target/amps_share
share/target/jars
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

Default SSL certificates are *self-generated*. You can include your certificates at `httpd/assets` folder


### Contributors
- [Bhagya Silva](http://about.me/bhagyas) - [Loftux AB](http://loftux.com?ref=githubx)