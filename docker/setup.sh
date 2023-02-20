#!/bin/bash

user=steam
echo "Downloading any updates for CS:GO..."
/steamcmd/steamcmd.sh +login anonymous \
  +force_install_dir /home/${user}/csgo \
  +app_update 740 \
  +quit

cd /home/${user}/csgo/csgo/warmod/ && python3 -m http.server 80 </dev/null &>/dev/null &

echo "Downloading map files..."
# cd to "csgo" parent directory so you are in the same folder as srcds
cd /home/${user}/csgo
if [ ! -d csgo-modded-server-assets ] ; then
	git clone --depth 1 https://github.com/kus/csgo-modded-server-assets.git
	cd csgo-modded-server-assets
	chmod +x copy.sh
	./copy.sh
fi
cd ../

cd /home/${user}

echo "Downloading mod files..."
cp -rf csgo-modded-server-master/csgo/ /home/${user}/csgo/
#cp -r csgo-modded-server-master/custom_files_example/* /home/${user}/csgo/custom_files/

echo "Dynamically writing /home/$user/csgo/csgo/cfg/secrets.cfg"
if [ ! -z "$RCON_PASSWORD" ]; then
	echo "rcon_password						\"$RCON_PASSWORD\"" > /home/${user}/csgo/csgo/cfg/secrets.cfg
fi
if [ ! -z "$STEAM_ACCOUNT" ]; then
	echo "sv_setsteamaccount					\"$STEAM_ACCOUNT\"			// Required for online https://steamcommunity.com/dev/managegameservers" >> /home/${user}/csgo/csgo/cfg/secrets.cfg
fi
if [ ! -z "$SERVER_PASSWORD" ]; then
	echo "sv_password							\"$SERVER_PASSWORD\"" >> /home/${user}/csgo/csgo/cfg/secrets.cfg
fi
echo "" >> /home/${user}/csgo/csgo/cfg/secrets.cfg
echo "echo \"secrets.cfg executed\"" >> /home/${user}/csgo/csgo/cfg/secrets.cfg

echo "Merging in custom files from ${CUSTOM_FOLDER}"
cp -RT /home/${user}/csgo/${CUSTOM_FOLDER}/ /home/${user}/csgo/csgo/

chown -R ${user}:${user} /home/${user}/csgo
