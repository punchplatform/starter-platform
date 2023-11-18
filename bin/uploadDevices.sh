#!/bin/bash
here="$(cd "$(dirname "$0")" && pwd)"
source ${here}/../INFO

upload_yaml() {
    local file_path="$1"

    # Check if the file exists
    if [ ! -f "$file_path" ]; then
        echo "Error: File $file_path not found."
        exit 1
    fi

    punchline_data=$(yq eval -o=json '. ' $file_path)
    json_data='{"punchline": '${punchline_data}'}'
    echo "$json_data" | curl -s -X POST -H 'Content-Type: application/json' -d @- ${ARTIFACT_SERVER_URL}/v1/devices/device
}

upload_yaml "${here}/../devices/cyber/ha_proxy_java.yaml"
upload_yaml "${here}/../devices/cyber/ha_proxy_rust.yaml"
upload_yaml "${here}/../devices/cyber/microsoft_snare.yaml"
upload_yaml "${here}/../devices/cyber/stormshield_networksecurity.yaml"