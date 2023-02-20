#!/bin/bash

docker build \
	-t csgo \
	$(for i in `cat env_file`; do out+="--build-arg $i " ; done; echo $out;out="") \
	. -f Dockerfile
