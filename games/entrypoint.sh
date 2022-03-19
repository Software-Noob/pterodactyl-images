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


# Update Sourcemod/metamod
if [ -f UPDATE_SM ] || [ "${SOURCEMOD}" = 1 ]; then
    mkdir -p /home/container/csgo/tmpfiles
    cd /home/container/csgo/tmpfiles
    echo "Updating Sourcemod/metamod..."
    curl -L -o sourcemod.tar.gz "https://sourcemod.net/latest.php?os=linux&version=${SM_VERSION}" -o metamod.tar.gz "https://sourcemm.net/latest.php?os=linux&version=${MM_VERSION}"
    echo "Extracting MM files"
	tar -xf metamod.tar.gz --directory /home/container/csgo
    echo "Extracting SM files"
    tar -xf sourcemod.tar.gz
    echo "Copying SM files"
    cp -R addons/sourcemod/{bin,extensions,gamedata} ../addons/sourcemod/
    echo "Done updating Sourcemod/metamod!"
    rm -rf /home/container/csgo/tmpfiles
fi
# Full Install Sourcemod/metamod for first time setup
if [ -f FULL_INSTALL ] || [ "${SOURCEMOD}" = 2 ]; then
    cd /home/container/csgo
    echo "Full installing Sourcemod/metamod..."
    curl -L -o sourcemod.tar.gz "https://sourcemod.net/latest.php?os=linux&version=${SM_VERSION}" -o metamod.tar.gz "https://sourcemm.net/latest.php?os=linux&version=${MM_VERSION}"
    echo "Extracting MM files"
	tar -xf metamod.tar.gz
    echo "Extracting SM files"
    tar -xf sourcemod.tar.gz
    echo "Deleting archives"
    rm sourcemod.tar.gz metamod.tar.gz
    echo "Done full installing Sourcemod/metamod!"
fi

cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
