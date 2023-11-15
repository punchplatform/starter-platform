# Demo Platform

This sample configuration works well with kooker or with a development setup.

It illustrates a simple yet fairly complete log management configuration. 
It consists of a central platform (whose configuration is under the 'conf' folder),
and four external devices that simulate (resp) microsoft, ha proxy and stormshield security logs.

Here are the few files to use: 

* INFO : contains the target punch server url. By default it points to kooker one.
* uploadConf.sh : upload the configuration to punch configuration server.
* uploadDevice.sh: uplad the devices information to punch central platform.

The folders are the following:

* conf/processing: a punch log parsing pipeline
* conf/ingestion: a punch HTTP punchline to receive traffic from external devices.
* conf/indexing: punch pipelines to insert the parsed logs or error documents into elasticsearch or opensearch
* devices: the punch devices to simulate external traffics. 

## Kooker Usage

To upload the configuration to Kooker simply type in: 

```sh
./bin/uploadConf.sh
```

You can then navigate to your punch board and start the various applications. 

Expose the Kooker HTTP service to your local host. The default network kooker configuration exposes a 8090 HTTP port. 
Once your Kooker is up and running, use a port forwarding: 

```sh
kubectl port-forward service/compact-ingestion-http-service 8090:8090
```

You can then start the various punchlines in the 'devices' folder. 

## Local Development Usage

Add the following to /etc/hosts:
```sh
127.0.0.1 ingestion.punchplatform.com
```

## Play with devices

A punch devices signals itself to the central Punch using a REST API. 
You can also pre-provision the devices directly. Type in:

```sh
./bin/uploadDevices.sh
```
Note that the devices will be considered active for 30 seconds. Punch device server maintains
a timeout for each. 