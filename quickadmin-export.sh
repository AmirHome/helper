#!/bin/bash

# check if the argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <search_string>"
    exit 1
fi

# search for files with the provided content and copy them to the export folder
grep -rl "$1" . | while read file; do
    # create the export directory if it doesn't exist
    mkdir -p "storage/framework/cache/data/export/$(dirname "$file")"
    cp "$file" "storage/framework/cache/data/export/$file"
done
