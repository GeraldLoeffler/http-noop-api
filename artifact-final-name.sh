#!/usr/bin/env bash

#
# returns something like http-noop-api-1.0.0
#

# dry-run to download all dependencies
mvn help:evaluate -Dexpression=project.build.finalName &> /dev/null

mvn help:evaluate -Dexpression=project.build.finalName | grep "^[^[]"
