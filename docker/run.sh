#!/bin/bash

docker run \
	-dit \
	--rm \
	--name csgo \
	--env-file env_file \
	--network host \
	-v csgo:/home/steam/csgo \
	-p 80:80 \
	-p 27000-27100:27000-27100 \
	csgo bash
