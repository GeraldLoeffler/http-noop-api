#!/usr/bin/env bash

set +x

export ANYPOINT_USERNAME="$1"
export ANYPOINT_PASSWORD="$2"
export ANYPOINT_ENVIRONMENT="$3"
export MULE_APP="$4"

echo Deploying $MULE_APP

anypoint-cli api-mgr api list -o json

set -x
