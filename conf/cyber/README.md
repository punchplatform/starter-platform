# Cyber Sample platform

This configuration illustrates a typical log management central platform that
receives logs from remote devices or remote sites. 

It demonstrates:
* log ingesting from external HTTP devices
* log parsing using ECS compliant parsers
* log archiving into compressed S3 CSV files
* log forwarding to an external HTTP server: an anonymisation function is deployed as a WASM artifact to ensure no IP is forwarded in clear text
* alert detection using SIGMA rules and automatically generated WASM functions



## Prerequisites

* around 30 minutes time

* have a linux workstation with:
	* Ubuntu 22 at least
	* 16+ GB RAM
	* sudoer rights
	* docker installed
	* an internet access with a good bandwidth (lots of cots will be downloaded)

## Setup

This demo requires a Kubernetes Instance, and deployed Punch services
You can achive these prerequisites using 'kooker' tool:

### Kooker Platform setup


* Kooker setup with needed Punch components:

	# Clone kooker tool:
	
		github.com:punchplatform/kooker.git
		cd kooker
		./install.sh
		source activate.sh

	# Configure kooker and start your K3D cluster, needed COTS and punch components deployment:
	
		kooker kpack kpack/kpack.punch.yaml  # This chooses the kastctl configuration that selects components to install
		kooker start

	# Check if everything is deployed

		kooker status

	# Try connecting to punch board
	
		kooker expose # This needs sudoer right to expose Web HMIs URLs locally
		kooker info 

		# Note that you have the default credentials exposed here for each tool

		# use the displayed punch-board URL

### Parsers prerequisites

This demo uses two companion start parser packages that must be loaded into the punch artifact server

* [start-parser](https://github.com/punchplatform/starter-parsers.git): that provides a single parser package with a syslog, apache and haproxy parsers.
* [start-sigma-rules](https://github.com/punchplatform/starter-sigma-rules.git): that provides a few sample Sigma rules. 

To install the parsers simply execute: 

```sh
git clone https://github.com/punchplatform/starter-parsers.git
cd starter-parsers
make package
make upload
cd ..
```

To install the sigma rules :
```sh
git clone https://github.com/punchplatform/starter-sigma-rules.git
cd starter-parsers
make package
make upload
cd ..
```

You can now check that your parsers artifacts are available in the platform artifact server by going to the 'Artifacts' tab of the punch-board
(Usually exposed at http://board.punch:8080/artifacts , but 'kooker info' will tell if needed...)

### Uploading the punchlines configuration to the platform

```bash
# Go to the directory that contains the starter-platform repository clone
cd starter-platform 

./bin/uploadConf.sh cyber
```


## Starting the demo

Go to the 'configuration' tab of punch-board Web GUI (normally expose on http://board.punch:8080/configurations, otherwise `kooker info` will tell)

You should see a 'cyber' folder that contains the imported items.

Each file in this configuration tree is a kubernetes resource, either a standard one (service, ingress...) or a punch one (streampunchline, batchpunchline, plan, platform...). Please refer to https://doc.punchplatform.com for reference on punch resources and punch nodes in punchlines


For each of the 'ingestion', 'indexing', 'processing', 'archiving', and finally 'simulator' folders,
select the folder then press the 'play' icon. ('detection' folder may require additional resources in order to be demonstrated)
  
on your kooker command line you can confirm that the punchlines have been submitted:

```bash
kubectl get spun,bpun -n default

NAME                                                                  STATUS
streampunchline.punchline.punchplatform.io/cyber-indexing-errors      Deployed
streampunchline.punchline.punchplatform.io/cyber-indexing-logs        Deployed
streampunchline.punchline.punchplatform.io/cyber-ingestion-http       Deployed
streampunchline.punchline.punchplatform.io/cyber-archiving-logs       Deployed
streampunchline.punchline.punchplatform.io/cyber-processing-parsing   Deployed
streampunchline.punchline.punchplatform.io/cyber-processing-forward   Deployed
streampunchline.punchline.punchplatform.io/cyber-simulator-logs       Deployed
```

In the Punch-board Web GUI, select the 'Topology' tab, and you should see the graph of the deployed punchlines, as well has a flow from the simulator punchline up to the elastic indices

You can view your logs in elasticsearch through kibana (by default, http://kibana.punch:8080, otherwise `kooker info` will tell):

* In Kibana, Go to 'Management => Stack Management' then Kibana=> Index Patterns
* Click on "Create index pattern"
* type 'default-*' as pattern name which should group all indices of the 'default' tenant we are demonstrating
* Click on 'next step
* select 'ts' for timefield
* validate by clicking on 'Create index pattern'
* Go to "Kibana=>Discover" and select the "default-*" pattern.
* You should see some indexed parsed documents and parsing error documents

Please note that the demo parsers are not fully compliant with the ECS datamodel, as they are only provided for this demo.

## View logs / Debug a punchline through GUI

In the "topology" view, right click on 'cyber-indexing-logs' punchline and select 'info' then 'events' tab
==> after a few seconds, you should see the logs of the punchline

At the top of the window, you can see that no tuple failures have occurred 


## non-gui punchlines start and operation

Instead of using punch-board to view/edit/start apps, you can use plain 'kubectl' from the command line:

- stop the 'processing' folder in the Web GUI
- through command line, start the 'processing' punchlines:

	cd conf/cyber
	kubectl apply -f processing -n default

- view the pods for your punchline

	```bash	
	kubectl get pods -n default -l punchline-name=cyber-processing-parsing
	NAME                                                         READY   STATUS            RESTARTS   AGE
	cyber-processing-parsing-18e81196d743c9e8-5d8fd487b9-skxsr   1/1     Running             0          25s
	```

- view the history and realtime logs for your punchline

	```bash
	kubectl logs -n default -l punchline-name=cyber-processing-parsing --tail -1 -f

	# PRESS <ctrl>-c to exit the logs flow

	http://kibana.punch:8080


Please note that by starting from the command-line using kubectl, we potentially did not use the same configuration version as the one stored  inside the punch-board configuration backend. For synchronization of these worlds, it is possible to configure a git backend to the punch-board (for example a gitea service as Kast can easily provide)