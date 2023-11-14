#!/bin/bash
here="$(cd "$(dirname "$0")" && pwd)"
source ${here}/../INFO

upload_yaml() {
    local file_path="$1"
    local endpoint="$2"

    # Check if the file exists
    if [ ! -f "$file_path" ]; then
        echo "Error: File $file_path not found."
        exit 1
    fi

    # Extract the file name from the path
    local file_name=$(basename "$file_path")

    # Perform the curl command to upload the file
    curl -X POST -F file="@$file_path" "${ARTIFACT_SERVER_URL}/$endpoint/$file_name"
    echo ""
}

upload_yaml "${here}/../conf/ingestion/http.yaml" "v1/configuration/ingestion"
upload_yaml "${here}/../conf/ingestion/http_ingress.yaml" "v1/configuration/ingestion"
upload_yaml "${here}/../conf/ingestion/http_service.yaml" "v1/configuration/ingestion"
upload_yaml "${here}/../conf/indexing/logs.yaml" "v1/configuration/indexing"
upload_yaml "${here}/../conf/indexing/errors.yaml" "v1/configuration/indexing"
upload_yaml "${here}/../conf/processing/parsing.yaml" "v1/configuration/processing"
upload_yaml "${here}/../conf/processing/aggregation.yaml" "v1/configuration/processing"
upload_yaml "${here}/../conf/simulator/logs.yaml" "v1/configuration/simulator"

