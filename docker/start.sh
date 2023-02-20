#!/bin/bash

cd /home/steam/csgo

PUBLIC_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
if [ -z "$PUBLIC_IP" ]; then
	echo "ERROR: Cannot retrieve your public IP address..."
	exit 1
fi
echo "Starting server on $PUBLIC_IP:$PORT"
./srcds_run \
    -console \
    -usercon \
    -autoupdate \
    -game csgo \
    -tickrate $TICKRATE \
    -port $PORT \
    +map de_dust2 \
    -maxplayers_override $MAXPLAYERS \
    -authkey $API_KEY \
    +ip 0.0.0.0 \
    +game_type 0 \
    +game_mode 0 \
    +mapgroup mg_active
