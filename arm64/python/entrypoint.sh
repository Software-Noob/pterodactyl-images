#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes. 
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

#Print the Python version
python --version

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e $(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}