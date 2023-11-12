#!/bin/bash
cd /home/container || exit 1

# Terminal Colors variables are not used, but only here for easier reference.
BOLD_WHITE='\033[1;37m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
RESET_COLOR='\033[0m'

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Available Egg Variables

###################################################################################################################
# SRCDS_APPID - Steam App ID of the game server (required) (ex: 740)                                              #
# SRCDS_BETAID - Steam App Beta ID of the game server (optional) (ex: 123456)                                     #
# SRCDS_BETAPASS - Steam App Beta Password of the game server (optional) (ex: password)                           #
# SOURCEMOD - Whether to install and update sourcemod/metamod on each startup (optional) (ex: 1, true, false, 0)  #
# SM_VERSION - Sourcemod version to install (optional) (ex: 1.11) (default: latest)                               #
# MM_VERSION - Metamod version to install (optional) (ex: 1.11) (default: latest)                                 #
# INSTALL_PATH - Path to install sourcemod/metamod to (optional) (ex: csgo) (default: csgo)                       #
###################################################################################################################

SOURCEMOD_LATEST="https://sourcemod.net/latest.php?os=linux&version=1.11"
METAMOD_LATEST="https://sourcemm.net/latest.php?os=linux&version=1.11"

print() {
    echo -e "$1"
}

print_bold_white() {
    echo -e "\033[1;37m$1\033[0m"
}

print_yellow() {
    echo -e "\033[0;33m$1\033[0m"
}

print_red() {
    echo -e "\033[0;31m$1\033[0m"
}

print_green() {
    echo -e "\033[0;32m$1\033[0m"
}

is_valid_url() {
    local URL="$1"
    curl --output /dev/null --silent --head --fail "$URL"
    return $?
}

download_default_stable() {
    print_bold_white "Defaulting to and downloading the latest stable SourceMod 1.11 and MetaMod 1.11 releases."
    curl --location --output sourcemod.tar.gz "$SOURCEMOD_LATEST" --output metamod.tar.gz "$METAMOD_LATEST"
}

# Auto detect the game install path by looking for the most common game folders. Default to csgo if none are found or provided by the user.
INSTALL_PATH="${INSTALL_PATH:-csgo}"

detect_install_path() {
    SUPPORTED_GAMES=("csgo" "tf" "css" "dod" "cstrike" "left4dead" "leftdead2" "contagion" "alienswarm" "orangebox" "orangebox_valve" "sdk2013" "original" "darkmessiah" "bloodygoodtime" "eye" "blade" "insurgency" "pvkii" "mcv" "hl2mp" "ship")

    for i in "${SUPPORTED_GAMES[@]}"; do
        if [[ -d /home/container/"${i}" ]]; then
            INSTALL_PATH="${i}"
        fi
    done
    print_bold_white "Current detected game install folder is: ${INSTALL_PATH}"
}

# Update Server
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
# TODO fix this mess of nested if statements in this whole script. It's not clear and hard to maintain.

# Install SourceMod/Metamod when egg variable SOURCEMOD is 1 or true. Otherwise, skip the whole step and act as normal server.
if [[ "${SOURCEMOD}" = 1 || "${SOURCEMOD}" == "true" ]]; then
    mkdir -p /home/container/"${INSTALL_PATH}"/tmpfiles
    cd /home/container/"${INSTALL_PATH}"/tmpfiles || exit 1

    print_yellow "SourceMod variable is set to 1 or true. Installing SourceMod/Metamod..."
    detect_install_path
    # Should custom versions be provided, check that they are valid. If not, use latest stable version.
    if [[ -n "${SM_VERSION}" ]]; then
        SOURCEMOD_SCRAPE=$(curl https://sm.alliedmods.net/smdrop/"${SM_VERSION}"/sourcemod-latest-linux -sS)
        SOURCEMOD_URL="https://sm.alliedmods.net/smdrop/${SM_VERSION}/${SOURCEMOD_SCRAPE}"

        # scrape the latest version of metamod for the specified sourcemod version and set it as METAMOD_URL
        if [[ -n "${MM_VERSION}" ]]; then
            METAMOD_SCRAPE=$(curl https://mms.alliedmods.net/mmsdrop/"${MM_VERSION}"/mmsource-latest-linux -sS)
            METAMOD_URL="https://mms.alliedmods.net/mmsdrop/${MM_VERSION}/${METAMOD_SCRAPE}"
        fi
    fi

    if [[ -z ${SOURCEMOD_URL} ]]; then
        download_default_stable
    else
        if is_valid_url "${SOURCEMOD_URL}"; then
            if is_valid_url "${METAMOD_URL}"; then
                curl --location --output sourcemod.tar.gz "${SOURCEMOD_URL}" --output metamod.tar.gz "${METAMOD_URL}"
            else
                print_red "The specified Metamod version: ${MM_VERSION} is not valid."
                download_default_stable
            fi
        else
            print_red "The specified SourceMod version: ${SM_VERSION} is not valid."
            download_default_stable
        fi
    fi

    # Extract SourceMod and Metamod
    print_bold_white "Extracting MetaMod files"
    tar -xf metamod.tar.gz --directory /home/container/"${INSTALL_PATH}"
    if [[ ! -f /home/container/${INSTALL_PATH}/cfg/sourcemod/sourcemod.cfg ]]; then
        print_bold_white "Existing sourcemod.cfg not found. Extracting all SourceMod files."
        tar -xf sourcemod.tar.gz --directory /home/container/"${INSTALL_PATH}"
    else
        print_bold_white "Existing sourcemod.cfg found. Extracting only the required files for an update\n"
        tar -xf sourcemod.tar.gz
        cp -R addons/sourcemod/{bin,extensions,gamedata,translations} ../addons/sourcemod/
    fi
    rm -rf "/home/container/${INSTALL_PATH}/tmpfiles"
    print_green "SourceMod and Metamod has been installed!\n"
else
    print_yellow "SOURCEMOD variable is set to false or 0. Skipping SourceMod and MetaMod installation..."

    if [[ -d /home/container/${INSTALL_PATH}/addons ]]; then
        print_yellow "Existing SourceMod install folder detected."
        print_yellow "Renaming the folder /home/container/${INSTALL_PATH}/addons and ${INSTALL_PATH}/cfg/sourcemod to backup and disable it.\n"
        mv "/home/container/${INSTALL_PATH}/addons" "/home/container/${INSTALL_PATH}/addons_disabled_$(date +%Y-%m-%d-%H:%M)"
        mkdir -p "/home/container/${INSTALL_PATH}/cfg_disabled"
        mv "/home/container/${INSTALL_PATH}/cfg/sourcemod" "/home/container/${INSTALL_PATH}/cfg_disabled/sourcemod_disabled_$(date +%Y-%m-%d-%H:%M)"
    fi
fi

cd /home/container || exit 1

# Replace Startup Variables
# shellcheck disable=SC2086
MODIFIED_STARTUP=$(eval echo "$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')")

# Display the parsed startup string we're going to execute.
print_yellow "[Startup Command]: ${BOLD_WHITE} ${MODIFIED_STARTUP}\n"

# Run the Server
# shellcheck disable=SC2086
eval ${MODIFIED_STARTUP}
