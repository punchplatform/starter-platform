# Cyber Sample platform

This configuration illustrates a typical log management central platform that
receives logs from remote devices or remote sites. 

It demonstrates:
* log ingesting from eternal HTTP devices
* log parsing using ECS compliant parsers
* log archiving into compressed S3 CSV files
* log forwarding to an external HTTP server: an anonymisation function is deployed as a WASM artifact to ensure no IP is forwarded in clear text
* alert detection using SIGMA rules and automatically generated WASM functions

## Before to start

This platform requires two companion start packages: 

* [start-parser](https://github.com/punchplatform/starter-parsers.git): that provides a single parser package with a syslog, apache and haproxy parsers.
* [start-sigma-rules](https://github.com/punchplatform/starter-sigma-rules.git): that provides a few sample Sigma rules. 

To install the parsers simply execute: 

```sh
git clone https://github.com/punchplatform/starter-parsers.git
cd starter-parsers
make upload
```

To install the sigma rules :
```sh
git clone https://github.com/punchplatform/starter-sigma-rules.git
cd starter-parsers
make upload
```