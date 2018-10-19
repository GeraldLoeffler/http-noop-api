#!/usr/bin/env bash

set +x

# so that aliases work
shopt -s expand_aliases

export ANYPOINT_USERNAME="$1"
export ANYPOINT_PASSWORD="$2"
export ANYPOINT_ENVIRONMENT="$3"
export MULE_APP="$4"

# shortcut to invoke Anypoint CLI
alias anypoint-cli="docker run --rm --name anypoint-cli -it integrational/anypoint-cli:3.0.0"

# set name to 'http-noop-api-1.0.0' or similar
name=$(mvn help:evaluate -Dexpression=project.build.finalName | grep "^[^\[]")

# set fullName to 'target/http-noop-api-1.0.0-mule-application.jar' or similar
fullName=$(ls target/$name*)

echo Deploying $fullName

$cli --environment=Staging api-mgr api list -o json

set -x
