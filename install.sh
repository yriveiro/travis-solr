#!/usr/bin/env bash

download() {
    local file="solr-$1.tgz"

    if [ ! -f "$file" ];
    then
        url="http://archive.apache.org/dist/lucene/solr/$1/solr-$1.tgz"

        echo "Downloading Solr $1"
        curl -g "$url" > "$file"
        echo "Downloaded."
    else
        echo "File $file already exists, skipping download".
    fi
}

up(){
    bash ./install_solr_service.sh "solr-$1.tgz" -u solr
}

unpacking() {
    tar xzf "solr-$1.tgz" "solr-$1/bin/install_solr_service.sh" --strip-components=2
}

check_version() {
    if [ -z "$SOLR_VERSION" ];
    then
        echo "No version provided."
        exit 1
    fi

    case $1 in 6.0.0|6.0.1|6.1.0|6.2.0|6.2.1);;
        *)
            echo "Sorry, $1 is not supported or not valid version."
            exit 1
            ;;
    esac
}

check_version "$SOLR_VERSION"
download "$SOLR_VERSION"
unpacking "$SOLR_VERSION"
