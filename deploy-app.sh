#!/usr/bin/env bash

set +x

export ANYPOINT_USERNAME="$1"
export ANYPOINT_PASSWORD="$2"
export ANYPOINT_ENV="$3"
export APP_ARCHIVE_FILENAME="$4" # relative to target directory!
export APP_NAME="$5"

echo Deploying Mule app $APP_ARCHIVE_FILENAME as $APP_NAME to $ANYPOINT_ENV

# evals to 1 if app already exists, 0 otherwise
appExists=$(anypoint-cli runtime-mgr cloudhub-application describe $APP_NAME -o text -f Domain | grep $APP_NAME | wc -l)
# modify all if it exists, otherwise deploy it
command=$(if [ $appExists == 1 ]; then echo modify; else echo deploy; fi)

echo Using $command command to deploy $APP_NAME

cd target # because APP_ARCHIVE_FILENAME is relative to target directory

anypoint-cli runtime-mgr cloudhub-application $command \
            --runtime 4.1.4 --workers 2 --workerSize 0.1 --region us-east-1 --autoRestart true \
            $APP_NAME $APP_ARCHIVE_FILENAME
