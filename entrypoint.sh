#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Check which branch to use
if [ ! -z ${RUST_BRANCH+x} ]; then
	echo "Using branch arguments: $RUST_BRANCH"

	# Add "-beta" if necessary
	INSTALL_BRANCH="${RUST_BRANCH}"
	if [ ! "$RUST_BRANCH" == "public" ]; then
	    INSTALL_BRANCH="-beta ${RUST_BRANCH}"
	fi
	sed -i "s/app_update 258550.*validate/app_update 258550 $INSTALL_BRANCH validate/g" /app/install.txt
else
	sed -i "s/app_update 258550.*validate/app_update 258550 validate/g" /app/install.txt
fi

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

if [ -f OXIDE_FLAG ] || [ "${OXIDE}" = 1 ] || [ "${UMOD}" = 1 ]; then
    echo "Updating uMod..."
    curl -sSL "https://umod.org/games/rust/download/develop" > umod.zip
    unzip -o -q umod.zip
    rm umod.zip
    echo "Done updating uMod!"
fi


# Fix for Rust not starting
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)

# Run the Server
node /wrapper.js "${MODIFIED_STARTUP}"
