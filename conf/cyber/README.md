# Cyber Sample platform

This platform illustrates a typical log management central platform that
receives logs from remote devices or remote sites. 

## Before to start

This platform requires two companion start packages: 

* (start-parser)[https://github.com/punchplatform/starter-parsers.git] : that provides a single parser package with a syslog, apache and haproxy parsers.
* start-sigma-rules[https://github.com/punchplatform/starter-sigma-rules.git]: that provides a few sample Sigma rules. 

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