#!/usr/bin/env bash

set +x

# so that aliases work
shopt -s expand_aliases

export ANYPOINT_USERNAME="$1"
export ANYPOINT_PASSWORD="$2"
export ANYPOINT_ENVIRONMENT="$3"
export MULE_APP="$4"

# shortcut to invoke Anypoint CLI
alias cli="anypoint-cli --username=$ANYPOINT_USERNAME --password=$ANYPOINT_PASSWORD --environment=$ANYPOINT_ENVIRONMENT"

echo Deploying $MULE_APP

anypoint-cli --username=$ANYPOINT_USERNAME --password=$ANYPOINT_PASSWORD --environment=$ANYPOINT_ENVIRONMENT api-mgr api list -o json

set -x
