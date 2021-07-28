FROM        azul/zulu-openjdk:8

LABEL       author="Software-noob" maintainer="admin@softwarenoob.com"
ENV         DEBIAN_FRONTEND noninteractive

RUN         apt update \
            && apt -y install ffmpeg iproute2 git sqlite3 python3 tzdata ca-certificates dnsutils build-essential \
            && useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
