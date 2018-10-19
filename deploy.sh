#!/usr/bin/env bash

set +x

alias anypoint-cli='docker run --rm --name anypoint-cli -it -e ANYPOINT_USERNAME="$(echo $ANYPOINT_USERNAME)" -e ANYPOINT_PASSWORD="$(echo $ANYPOINT_PASSWORD)" integrational/anypoint-cli:3.0.0'

export ANYPOINT_USERNAME=$1
export ANYPOINT_PASSWORD=$2

# set name to 'http-noop-api-1.0.0' or similar
name=$(mvn help:evaluate -Dexpression=project.build.finalName | grep "^[^\[]")

# set fullName to 'target/http-noop-api-1.0.0-mule-application.jar' or similar
fullName=$(ls target/$name*)

echo Deploying $fullName with AP credentials $ANYPOINT_USERNAME and $ANYPOINT_PASSWORD
echo TODO

anypoint-cli --environment=Staging api-mgr api list -o json

set -x
