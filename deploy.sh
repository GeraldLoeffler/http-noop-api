#!/usr/bin/env bash

set +x

export ANYPOINT_USERNAME=$1
export ANYPOINT_PASSWORD=$2

# set name to 'http-noop-api-1.0.0' or similar
name=$(mvn help:evaluate -Dexpression=project.build.finalName | grep "^[^\[]")

# set fullName to 'target/http-noop-api-1.0.0-mule-application.jar' or similar
fullName=$(ls target/$name*)

echo Deploying $fullName with AP credentials $ANYPOINT_USERNAME and $ANYPOINT_PASSWORD
echo TODO

set -x
