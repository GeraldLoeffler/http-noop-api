#!/usr/bin/env bash

#
# returns http-noop-api-1.0.0 for a Maven project with artifactId=http-noop-api and version=1.0.0
#

# dry-run to download all dependencies
mvn help:evaluate -Dexpression=project.build.finalName &> /dev/null

# real run with result sent to stdout
mvn help:evaluate -Dexpression=project.build.finalName | grep "^[^[]"
