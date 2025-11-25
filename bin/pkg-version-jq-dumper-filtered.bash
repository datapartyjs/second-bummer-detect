#!/bin/bash

# Path to a package.json
FILE=$1

# Check if version argument is provided
if [ -z "$FILE" ]; then
  echo "Usage: $0 <package.json>"
  echo "Example: $0 ~/my-project/package.json
  exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "File $FILE not found."
    exit 1
fi

# 1. Read dependencies and devDependencies (defaulting to empty objects if missing)
# 2. Merge them (+)
# 3. Convert to entries (key/value pairs)
# 4. Print as "Package Version"
jq -r '(.dependencies // {}) + (.devDependencies // {}) | to_entries[] | "\(.key) \(.value)"' $FILE 


#|  grep -E '^[^ ]+ [\^~]?[0-9]' | sed 's/\(^[^ ]*\) [\^~]\(.*\)/\1 \2/'
