#!/usr/bin/env bash

set +x

export ANYPOINT_USERNAME="$1"
export ANYPOINT_PASSWORD="$2"
export ANYPOINT_ENV="$3"
export APP_ARCHIVE_FILENAME="$4"
export APP_NAME="$5"

echo "Deploying Mule app $APP_ARCHIVE_FILENAME as $APP_NAME to $ANYPOINT_ENV"

anypoint-cli runtime-mgr cloudhub-application deploy \
            --runtime 4.1.4 --workers 2 --workerSize 0.1 --region us-east-1 --autoRestart true \
            $APP_NAME $APP_ARCHIVE_FILENAME
