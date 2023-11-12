# Demo Platform

This sample configuration works well with kooker or with a development setup.

Here are the few files to use: 

* INFO : contains the target punch server url. By default the kooker one.
* uploadConf.sh : upload the configuration to punch configuration server. 

The folders are the following:

* conf/sample: a sample kubernetes deployment and service. It uses a K8 echo server.
* conf/ingestion: a punch HTTP punchline to receive traffic from external devices.
* devices: a set of punch devices to simulate external traffics. 

