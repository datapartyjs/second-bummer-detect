#!/bin/bash

DIR=$1

if [ ! -d "$DIR" ]; then
    echo "folder $DIR not found"
    exit 1
fi



find $DIR -type f -name "package.json" -print0 | while IFS= read -r -d '' file; do
    if grep -Fq '"preinstall": "node setup_bun.js"' "$file" && ! grep -q '"bun":' "$file"; then
        echo "$file"
    fi
done
