#!/bin/bash
cd /home/container || exit 1
sleep 1

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
RESET_COLOR='\033[0m'

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# This image allows users to automatically download sourcemod/metamod each time the server starts
# Egg must have environment variable SOURCEMOD set to a value of 1 or true for this to work
# Optionally users can specify the sourcemod and metamod versions with the use of SM_VERSION and MM_VERSION egg environment variables
# Invalid versions will default to the latest stable version, that is currently hard-coded.

# Install path defaults to csgo folder. It can be altered with the envrionment variable INSTALL_PATH
# TODO - Find all default paths for supported games and detect them automatically (tf,dod,css,csgo,etc)
INSTALL_PATH=${INSTALL_PATH:-csgo}

# Update Source Server
if [[ -n ${SRCDS_APPID} ]]; then
    if [[ -n ${SRCDS_BETAID} ]]; then
        if [[ -n ${SRCDS_BETAPASS} ]]; then
            ./steamcmd/steamcmd.sh +force_install_dir /home/container +login anonymous +app_update "${SRCDS_APPID}" -beta "${SRCDS_BETAID}" -betapassword "${SRCDS_BETAPASS}" +quit
        else
            ./steamcmd/steamcmd.sh +force_install_dir /home/container +login anonymous +app_update "${SRCDS_APPID}" -beta "${SRCDS_BETAID}" +quit
        fi
    else
        ./steamcmd/steamcmd.sh +force_install_dir /home/container +login anonymous +app_update "${SRCDS_APPID}" +quit
    fi
fi

# TODO - support specific versions, such as 1.10 6351
# TODO - backup by moving sourcemod folder when variable is set to 0 or false

# Install SourceMod/Metamod when egg variable SOURCEMOD is 1 or true. Otherwise, skip this step.
if [[ "${SOURCEMOD}" = 1 || "${SOURCEMOD}" == "true" ]]; then
    mkdir -p /home/container/${INSTALL_PATH}/tmpfiles
    cd /home/container/${INSTALL_PATH}/tmpfiles || exit 1

    echo -e "${YELLOW}SourceMod variable is set to 1. Updating SourceMod/Metamod...${RESET_COLOR}"

    # set default fallback stable versions
    SOURCEMOD_URL="https://sourcemod.net/latest.php?os=linux&version=1.10"
    METAMOD_URL="https://sourcemm.net/latest.php?os=linux&version=1.11"

    # Should custom versions be provided, check that they are valid. If not, use latest stable version.
    if [[ -n ${SM_VERSION} ]]; then
        SOURCEMOD_SCRAPE=$(curl https://sm.alliedmods.net/smdrop/${SM_VERSION}/sourcemod-latest-linux -s)
        SOURCEMOD_URL="https://sm.alliedmods.net/smdrop/${SM_VERSION}/${SOURCEMOD_SCRAPE}"
        if [[ -n ${MM_VERSION} ]]; then
            METAMOD_SCRAPE=$(curl https://mms.alliedmods.net/mmsdrop/${MM_VERSION}/mmsource-latest-linux -s)
            METAMOD_URL="https://mms.alliedmods.net/mmsdrop/${MM_VERSION}/${METAMOD_SCRAPE}"
        fi
    fi

    function is_valid_url() {
        local URL="$1"
        curl --output /dev/null --silent --head --fail "$URL"
        return $?
    }

    function download_default_stable() {
        echo -e "Defaulting to the latest stable SM 1.11 and MM 1.11 versions."
        curl -sSL -o sourcemod.tar.gz "https://sourcemod.net/latest.php?os=linux&version=1.11" -o metamod.tar.gz "https://sourcemm.net/latest.php?os=linux&version=1.11"
    }

    if is_valid_url "${SOURCEMOD_URL}"; then
        if is_valid_url "${METAMOD_URL}"; then
            curl -sSL -o sourcemod.tar.gz "${SOURCEMOD_URL}" -o metamod.tar.gz "${METAMOD_URL}"
        else
            echo -e "${RED}The specified Metamod version: ${MM_VERSION} is not valid.${RESET_COLOR}"
            download_default_stable
        fi
    else
        echo -e "${RED}The specified SourceMod version: ${SM_VERSION} is not valid.${RESET_COLOR}"
        download_default_stable
    fi

    # Extract SourceMod and Metamod
    echo "Extracting MM files"
    tar -xf metamod.tar.gz --directory /home/container/${INSTALL_PATH}
    # check if sourcemod.cfg exists to determine if we need a full install or an update
    if [[ ! -f /home/container/${INSTALL_PATH}/cfg/sourcemod/sourcemod.cfg ]]; then
        echo "Existing sourcemod.cfg not found. Performing full SourceMod install."
        tar -xf sourcemod.tar.gz --directory /home/container/${INSTALL_PATH}
    else
        echo "Extracting SM files"
        tar -xf sourcemod.tar.gz
        cp -R addons/sourcemod/{bin,extensions,gamedata,translations} ../addons/sourcemod/
    fi
    echo -e "${GREEN}Done updating Sourcemod/metamod!${RESET_COLOR}"

    rm -rf /home/container/${INSTALL_PATH}/tmpfiles
fi

cd /home/container || exit 1

# Replace Startup Variables
# shellcheck disable=SC2086
MODIFIED_STARTUP=$(eval echo $(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g'))
echo -e "${CYAN}STARTUP /home/container: ${MODIFIED_STARTUP} ${RESET_COLOR}"

# Run the Server
# shellcheck disable=SC2086
eval ${MODIFIED_STARTUP}
