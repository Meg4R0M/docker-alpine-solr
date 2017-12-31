#!/bin/sh

echo [`date`] Bootstrapping Solr...

function clean_up {
    # Perform program exit housekeeping
    echo [`date`] Stopping the service...
    killall solr
    exit
}

echo [`date`] Starting the service...

trap clean_up SIGTERM

BASEDIR=/opt/solr

cd $BASEDIR

#exec sh solr.sh -f -m ${SOLR_HEAP_SIZE}

echo [`date`] Bootstrap finished

tail -f /dev/null &
child=$!
wait "$child"