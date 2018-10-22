#!/usr/bin/env bash

set +x

export ANYPOINT_USERNAME="$1"
export ANYPOINT_PASSWORD="$2"
export ANYPOINT_ENV="$3"
export APP_ARCHIVE_FILENAME="$4" # relative to target directory!
export APP_NAME="$5"

echo Deploying Mule app $APP_ARCHIVE_FILENAME as $APP_NAME to $ANYPOINT_ENV

# evals to 1 if app already exists, 0 otherwise
appExists=$(anypoint-cli runtime-mgr cloudhub-application describe $APP_NAME -o text -f Status | grep Status | wc -l)
# use 'modify' if app already exists, use 'deploy' otherwise
command=$(if [ $appExists == 1 ]; then echo modify; else echo deploy; fi)
echo Using $command command to deploy $APP_NAME

propsFilename="deploy-app-$ANYPOINT_ENV.env"
echo Using deployment properties from $propsFilename
eval $(awk '{print "export " $1}' $propsFilename) # so that file just sets vars, without export

cd target # because APP_ARCHIVE_FILENAME is relative to target directory

anypoint-cli runtime-mgr cloudhub-application $command \
            --runtime $runtime --workers $workers --workerSize $workerSize --region $region \
            --persistentQueues $persistentQueues --persistentQueuesEncrypted $persistentQueuesEncrypted 
            --staticIPsEnabled $staticIPsEnabled --autoRestart $autoRestart \
            $APP_NAME $APP_ARCHIVE_FILENAME
