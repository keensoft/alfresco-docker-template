#!/bin/bash
set -e

if [ "$1" == "run" ]
then
	pushd $SOLR_DIR > /dev/null
	bash ./solr/bin/solr start -Dcreate.alfresco.defaults=alfresco,archive
	tail -f ./logs/solr.log
	popd > /dev/null
else
	exec "$@"
fi
