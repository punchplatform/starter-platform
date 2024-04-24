# Cyber Sample platform

This configuration illustrates a typical ELK log management central platform that
receives logs from remote devices or remote sites.

It is used by the RIFT team to demonstrate keda, karpenter and rift capabilities
to scale up or down a realistic application.

It contains:
* log ingesting from eternal HTTP devices
* log parsing using ECS compliant parsers
* log archiving into compressed S3 CSV files

## Applications: 

* test/sample.yaml: a test deployment that always work but does nothing. Useful to test Keda.
* test/logs.yaml: a simulator to inject logs into Kafka. Makes it easier to test without requiring external probes or agent to simulates logs.
* ingestion/http.yaml: the receiving application. It expects to receive logs from the remote probes.

## Before to start

This platform is WIP. As of now it only has the ingestion and sample applications.  
