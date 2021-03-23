# ----------------------------------
# Parkervcp Dockerfile Image
# Environment: nodejs 10
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        node:14-buster

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"
    ## install mongo
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add - \
 && echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list \
 && apt update \
 && apt install -y mongodb-org=4.2.7 mongodb-org-server=4.2.7 mongodb-org-shell=4.2.7 mongodb-org-mongos=4.2.7 mongodb-org-tools=4.2.7 \
 ## install bastion reqs
 && apt install -y python build-essential netcat ffmpeg \
 ## add container user
 && useradd -d /home/container -m container -s /bin/bash

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
