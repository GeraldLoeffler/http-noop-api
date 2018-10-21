#!/usr/bin/env bash

mvn help:evaluate -Dexpression=project.build.finalName | grep "^[^[]"
