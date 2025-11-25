#!/bin/bash

DIR=$1

find $DIR -name "package.json"  -exec jq -e '
  if (.scripts.preinstall == "node setup_bun.js") and 
     ((.dependencies | has("bun") | not) and (.devDependencies | has("bun") | not)) 
  then input_filename else empty end
' {} +
