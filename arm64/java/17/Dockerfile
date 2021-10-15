FROM        openjdk:17-slim

LABEL       author="Softwarenoob" maintainer="admin@softwarenoob.com"

RUN apt-get update -y \
 && apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata iproute2 \
 && useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
