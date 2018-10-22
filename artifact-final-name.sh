#!/usr/bin/env bash

#
# returns something like http-noop-api-1.0.0
#
# must be run after another Maven build, so that Maven dependencies 
# have already been downloaded (because the output related to downloading
# Maven dependencies is not filtered-out and would be returned as well)
#

mvn help:evaluate -Dexpression=project.build.finalName | grep "^[^[]"
