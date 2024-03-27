# Demo Platform

This sample configuration works well with kooker or with a development setup.
It provides simple yet complete and realistic examples for you to start from.

* conf/cyber: a log management architecture with real-time ingestion parsing, indexing and archiving.
* conf/flights: based on Kibana sample flight data. It provides simple examples to work with plans and batch applications.
* conf/samples: these are much simpler examples for you to quickly find out a starting example.

Here are the few files to use: 

* INFO : contains the target punch REST server url. By default, it points to the kooker one.
* bin/uploadConf.sh : upload the configuration you want to punch configuration server.
* bin/uploadDevice.sh: upload the devices information to punch central platform. This is not necessary, the device will automatically provision itself once started.


## Kooker Usage

Platform prerequisites setup steps are fully decribed in conf/cyber/README.md

If you already have a provisionned kooker with punch services deployed, then to upload the configuration to Kooker simply type in: 

```sh
./bin/uploadConf.sh cyber
```
Use conf of 'cyber', 'flights', 'sample' or 'all' to load wnat you want. 

You can then navigate to your punch board and start the various applications. 

The 'cyber' configuration allow you to send data from external devices on HTTP port 8090.
You may need (on Macos) to expose the correspondng ingress HTTP service to your local host. 
Once your Kooker is up and running, use a port forwarding: 

```sh
kubectl port-forward service/ingestion-http-service 8090:8090
```

You can then start the various punchlines in the 'cyber/devices' folder. Each simulates a log agent.

## Local Development Usage

Add the following to /etc/hosts:
```sh
127.0.0.1 ingestion.punchplatform.com
```
It works as is with a local artifact server and punch board. 

## Play with devices

A punch devices signals itself to the central Punch using a REST API. You will see
them appear in your punch board automatically as soon as they send traffic.
You can also pre-provision the devices directly using Punch device REST api. Type in:

```sh
./bin/uploadDevices.sh
```

Note that the devices will be considered active for 30 seconds. ThepPunch device 
server maintains a timeout for each. 