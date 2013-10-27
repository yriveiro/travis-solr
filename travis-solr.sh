#!/usr/bin/env bash

download() {
    case $1 in
        4.0.0)
            url="http://archive.apache.org/dist/lucene/solr/4.0.0/apache-solr-4.0.0.tgz"
            dir_name="apache-solr-4.0.0"
            dir_conf="collection1/conf/"
            ;;
        4.1.0)
            url="http://archive.apache.org/dist/lucene/solr/4.1.0/solr-4.1.0.tgz"
            dir_name="solr-4.1.0"
            dir_conf="collection1/conf/"
            ;;
        4.2.0)
            url="http://archive.apache.org/dist/lucene/solr/4.2.0/solr-4.2.0.tgz"
            dir_name="solr-4.2.0"
            dir_conf="collection1/conf/"
            ;;
        4.2.1)
            url="http://archive.apache.org/dist/lucene/solr/4.2.1/solr-4.2.1.tgz"
            dir_name="solr-4.2.1"
            dir_conf="collection1/conf/"
            ;;
        4.4.0)
            url="http://archive.apache.org/dist/lucene/solr/4.4.0/solr-4.4.0.tgz"
            dir_name="solr-4.4.0"
            dir_conf="collection1/conf/"
            ;;
        4.5.0)
            url="http://archive.apache.org/dist/lucene/solr/4.5.0/solr-4.5.0.tgz"
            dir_name="solr-4.5.0"
            dir_conf="collection1/conf/"
            ;;
        4.5.1)
            url="http://archive.apache.org/dist/lucene/solr/4.5.1/solr-4.5.1.tgz"
            dir_name="solr-4.5.1"
            dir_conf="collection1/conf/"
            ;;
    esac

    echo "Downloading Solr from $url ..."
    curl -s $url | tar xz
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
#run $SOLR_VERSION
