run: setup_volumes
	docker-compose up -d

setup_volumes:
	docker volume create alf-repo-data
	docker volume create postgres-data
	docker volume create solr-data

clean: 
	docker volume remove alf-repo-data
	docker volume remove postgres-data
	docker volume remove solr-data

default: run