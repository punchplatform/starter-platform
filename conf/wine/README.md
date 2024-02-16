1# Wine Sample platform

The Wine Sample platform illustrates a typical data science workflow, involving the processing of a dataset and making predictions using either the Python engine or the Spark engine.

It demonstrates:
* dataset ingestion from S3 Bucket
* loading a pre-trained machine learning model for predictive analysis.
* computing predictions

## Before to start

Before initiating the platform, certain prerequisites need to be met:

* Create a S3 bucket and upload the dataset in it
* Upload the artifact containing the machine learning model

To create the required S3 bucket and upload the dataset, follow these steps:

1. Connect to the Minio web interface at http://minio.punch:8080 and log in using the provided credentials (default: username - minioadmin, password - minioadmin).
2. In the Buckets interface, create an S3 bucket named "data"
3. In the Objects Browser interface, select the "data" bucket and upload the dataset located in ```resources/wine/data/winequality-red.csv```.

If you want to use "wine_quality_flink.yaml" you must provide credential to the artifactory registry :

1. ```shell
    export DOCKER_USERNAME="your-username"
    export DOCKER_PASSWORD="your-token"
    ```
2. ```shell
    kubectl create secret docker-registry regcred --docker-server=artifactory.thalesdigital.io --docker-username=$DOCKER_USERNAME --docker-password=$DOCKER_PASSWORD
    ```
3. ```shell
    kubectl apply -f service-account.yaml
    ```
To upload the artifact containing the machine learning model, execute the following command at the root of the project:

```sh
./bin/uploadArtifacts.sh wine
```

Ensure that the ARTIFACT_SERVER_URL variable is correctly set in the INFO file.

By completing these steps, the Wine Sample platform will be ready for use.