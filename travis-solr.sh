#!/usr/bin/env bash

download() {
    echo "Downloading Solr from $1 ..."
    curl -s $1 | tar xz
    echo "Downloaded."
}

up(){
    http_code=`echo $(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8983/solr/admin/ping")`
    return `test $http_code = "200"`
}

wait_for_solr(){
    while ! up; do
        echo "Solr not ready yet, sleeping 3 seconds ..."
        sleep 3
    done
}

run() {
    echo "Starting solr ..."

    cd $1/example

    if [ $DEBUG ]
    then
        java -Dbootstrap_confdir=./solr/collection1/conf -Dcollection.configName=default -DzkRun -DnumShards=2 -jar start.jar &
    else
        java -Dbootstrap_confdir=./solr/collection1/conf -Dcollection.configName=default -DzkRun -DnumShards=2 -jar start.jar  > /dev/null 2>&1 &
    fi

    wait_for_solr

    cd ../../

    echo "Started"
}

check_version() {
    case $1 in
        4.0.0|4.1.0|4.2.0|4.2.1|4.4.0|4.5.0|4.5.1);;
        *)
            echo "Sorry, $1 is not supported or not valid version."
            exit 1
            ;;
    esac
}

check_version $SOLR_VERSION
download $SOLR_VERSION
run $SOLR_VERSION