#!/usr/bin/env bash

set +x
# set name to 'http-noop-api-1.0.0' or similar
name=$(mvn help:evaluate -Dexpression=project.build.finalName | grep "^[^\[]")

# set fullName to 'target/http-noop-api-1.0.0-mule-application.jar' or similar
fullName=$(ls target/$name*)
set -x

echo Deploying $fullName
echo TODO
