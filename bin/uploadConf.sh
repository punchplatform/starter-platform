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
    
    find "$directory" \( -name '*.yaml' -o -name '*.md' \) -print0 | while IFS= read -r -d '' file_path; do
        if [ -f "$file_path" ]; then
            echo "$file_path"
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

directory_choice="$1"
case "$directory_choice" in
    "radar")
        upload_all_yaml "${here}/../conf/radar"
        ;;
    "cyber")
        upload_all_yaml "${here}/../conf/cyber"
        ;;
    "flights")
        upload_all_yaml "${here}/../conf/flights"
        ;;
    "samples")
        upload_all_yaml "${here}/../conf/samples"
        ;;
    "wine")
        upload_all_yaml "${here}/../conf/wine"
        ;;
    "all")
        upload_all_yaml "${here}/../conf/cyber"
        upload_all_yaml "${here}/../conf/flights"
        upload_all_yaml "${here}/../conf/samples"
        upload_all_yaml "${here}/../conf/wine"
        upload_all_yaml "${here}/../conf/radar"
        ;;
    *)
        echo "Please choose 'cyber', 'flights', 'samples','wine', 'radar'  or 'all'."
        exit 1
        ;;
esac

