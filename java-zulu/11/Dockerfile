FROM        azul/zulu-openjdk:11

LABEL       author="Software-noob" maintainer="admin@softwarenoob.com"
ENV         DEBIAN_FRONTEND noninteractive

RUN         apt-get update \
            && apt-get -y install --no-install-recommends ffmpeg iproute2 git sqlite3 python3 tzdata ca-certificates dnsutils fontconfig libfreetype6 build-essential \
            && apt-get clean \
            && rm -rf /var/lib/apt/lists/* \
            && useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
