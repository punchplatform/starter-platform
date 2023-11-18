#!/bin/bash
here="$(cd "$(dirname "$0")" && pwd)"
source ${here}/../INFO

upload_all_yaml() {
    local directory="$1"

    # Check if the directory exists
    if [ ! -d "$directory" ]; then
        echo "Error: Directory $directory not found."
        exit 1
    fi
    # Iterate over all YAML files in the directory
    for file_path in $(find ${directory} -name '*.yaml') 
    do
        if [ -f "$file_path" ]; then
            upload_yaml "$file_path"
        fi
    done
}

upload_yaml() {
    local file_path="$1"

    # Check if the file exists
    if [ ! -f "$file_path" ]; then
        echo "Error: File $file_path not found."
        exit 1
    fi

    # Extract the file name from the path
    local file_name=$(basename "$file_path")
    # derive endpoint from path
    local endpoint=$(dirname "${file_path#${here}/../conf}") 

    # Perform the curl command to upload the file
    curl -X POST -F file="@$file_path" "${ARTIFACT_SERVER_URL}/v1/configuration$endpoint/$file_name"
    echo ""
}

upload_all_yaml "${here}/../conf/cyber"
#upload_all_yaml "${here}/../conf/flights"

