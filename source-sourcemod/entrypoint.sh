#!/bin/bash
cd /home/container
sleep 1
# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Update Source Server
if [ ! -z ${SRCDS_APPID} ]; then
    if [ ! -z ${SRCDS_BETAID} ]; then
        if [ ! -z ${SRCDS_BETAPASS} ]; then
            ./steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container +app_update ${SRCDS_APPID} -beta ${SRCDS_BETAID} -betapassword ${SRCDS_BETAPASS} +quit
        else
            ./steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container +app_update ${SRCDS_APPID} -beta ${SRCDS_BETAID} +quit
        fi
    else
        ./steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container +app_update ${SRCDS_APPID} +quit
    fi
fi

cd /home/container/csgo
# Install Sourcemod/metamod
if [ -f SOURCE_FLAG ] || [ "${SOURCEMOD}" = 1 ]; then
    echo "Updating Sourcemod/metamod..."
    curl -sSL -o sourcemod.tar.gz "https://sourcemod.net/latest.php?os=linux&version=1.10" -o metamod.tar.gz "https://sourcemm.net/latest.php?os=linux&version=1.11"
	curl -sSL -o metamod.tar.gz "https://sourcemm.net/latest.php?os=linux&version=1.11"
    tar -xf sourcemod.tar.gz
	tar -xf metamod.tar.gz
    rm sourcemod.tar.gz metamod.tar.gz
    echo "Done updating Sourcemod/metamod!"
fi

cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}