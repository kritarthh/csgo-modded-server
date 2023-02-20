#!/bin/bash

#ensure environment variables are present
for VAR in API_KEY STEAM_ACCOUNT DUCK_DOMAIN DUCK_TOKEN ; do
	[ -z "${!VAR}" ] && { echo "$VAR missing"; exit 1; } || export $VAR
	echo "exported $VAR"
done
[ -z "$RCON_PASSWORD" ] && export RCON_PASSWORD=kritarth || export RCON_PASSWORD
[ -z "$MOD_URL" ] && export MOD_URL=https://github.com/kus/csgo-modded-server/archive/master.zip || export MOD_URL
[ -z "$SERVER_PASSWORD" ] && export SERVER_PASSWORD=maingate || export SERVER_PASSWORD
[ -z "$PORT" ] && export PORT=27015 || export PORT
[ -z "$TICKRATE" ] && export TICKRATE=128 || export TICKRATE
[ -z "$MAXPLAYERS" ] && export MAXPLAYERS=16 || export MAXPLAYERS
[ -z "$CUSTOM_FOLDER" ] && export CUSTOM_FOLDER=custom_files || export CUSTOM_FOLDER

# Update DuckDNS with our current IP
if [ ! -z "$DUCK_TOKEN" ]; then
    echo url="http://www.duckdns.org/update?domains=$DUCK_DOMAIN&token=$DUCK_TOKEN&ip=$(dig +short myip.opendns.com @resolver1.opendns.com)" | curl -k -o /duck.log -K -
fi

/setup.sh
su steam -s /start.sh
