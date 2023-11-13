# Demo Platform

This sample configuration works well with kooker or with a development setup.

Here are the few files to use: 

* INFO : contains the target punch server url. By default the kooker one.
* uploadConf.sh : upload the configuration to punch configuration server. 

The folders are the following:

* conf/processing: a punch log parsing pipeline
* conf/ingestion: a punch HTTP punchline to receive traffic from external devices.
* conf/indexing: punch pipelines to insert the parsed logs or error documents into elasticsearch or opensearch
* devices: a set of punch devices to simulate external traffics. 

## Kooker usage

To upload the configuration to Kooker simply type in: 

```sh
./bin/upload.sh
```

You can then navigate to your punch board and start the various applications. 

Next expose the Kooker HTTP service to your local host. The default network kooker configuration exposes a 8090 HTTP port. 
Once your Kooker is up and running, use a port forwarding: 

```sh
kubectl port-forward service/compact-ingestion-http-service 8090:8090
```

You can then start the various punchlines in the 'devices' folder.  