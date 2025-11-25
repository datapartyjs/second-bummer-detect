#!/bin/bash

FILE=$1

if [ ! -f "$FILE" ]; then
    echo "can not find file $FILE. Pass a package-lock.json"
    exit 1
fi

jq -r '
  .packages // .dependencies | 
  to_entries[] | 
  select(.value.version != null) | 
  select(.value.version | test("^[0-9]+\\.[0-9]+\\.[0-9]+")) |
  "\(.key | sub("^node_modules/"; "") | sub(".*/node_modules/"; "")) \(.value.version)"
' $FILE | sort
