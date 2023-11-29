#!/bin/bash
here="$(cd "$(dirname "$0")" && pwd)"
source ${here}/../INFO

upload_all_devices() {
    local directory="$1"
    # Check if the directory exists
    if [ ! -d "$directory" ]; then
        echo "Error: Directory $directory not found."
        exit 1
    fi
    # Iterate over all YAML files in the directory
    find "$directory" \( -name '*.yaml' -o -name '*.md' \) -print0 | while IFS= read -r -d '' file_path; do
        if [ -f "$file_path" ]; then
            echo $file_path
            upload_devices "$file_path"
        fi
    done
}


upload_devices() {
    local file_path="$1"
    # Check if the file exists
    if [ ! -f "$file_path" ]; then
        echo "Error: File $file_path not found."
        exit 1
    fi

    punchline_data=$(yq eval -o=json '. ' $file_path)
    json_data='{"punchline": '${punchline_data}'}'
    echo "$json_data" | curl -X POST -H 'Content-Type: application/json' -d @- ${ARTIFACT_SERVER_URL}/v1/devices/device
}


directory_choice="$1"
case "$directory_choice" in
    "radar")
        upload_all_devices "${here}/../devices/radar"
        ;;
    "cyber")
        upload_all_devices "${here}/../devices/cyber"
        ;;
    "all")
        upload_all_devices "${here}/../devices/cyber"
        upload_all_devices "${here}/../devices/radar"
        ;;
    *)
        echo "Please choose 'cyber', 'radar'  or 'all'."
        exit 1
        ;;
esac