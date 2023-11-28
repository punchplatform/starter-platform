#!/bin/bash
here="$(cd "$(dirname "$0")" && pwd)"
source ${here}/../INFO

upload_all_artifacts() {
    local directory="$1"

    # Check if the directory exists
    if [ ! -d "$directory" ]; then
        echo "Error: Directory $directory not found."
        exit 1
    fi
    # Iterate over all zip files in the directory
    
    find "$directory" \( -name '*.zip' -o -name '*.md' \) -print0 | while IFS= read -r -d '' file_path; do
        if [ -f "$file_path" ]; then
            upload_artifact "$file_path"
        fi
    done
}

upload_artifact() {
    local file_path="$1"

    # Check if the file exists
    if [ ! -f "$file_path" ]; then
        echo "Error: File $file_path not found."
        exit 1
    fi

    # Perform the curl command to upload the artifact
    curl -XPOST "${ARTIFACT_SERVER_URL}/v1/artifacts/upload" -F artifact="@$1" -F override=true
    echo ""
}

directory_choice="$1"
case "$directory_choice" in
    "wine")
        upload_all_artifacts "${here}/../resources/wine/artifacts"
        ;;
    "all")
        upload_all_artifacts "${here}/../resources/wine/artifacts"
        ;;
    *)
        echo "Please choose 'wine', 'radar' or 'all'."
        exit 1
        ;;
esac

