#!/bin/bash

mkdir -p devsecops-app
cd devsecops-app || exit 1

mvn archetype:generate \
  -DgroupId=com.demo \
  -DartifactId=devsecops-app \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false
