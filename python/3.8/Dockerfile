FROM        python:3.8-slim

LABEL       author="Software-noob" maintainer="admin@softwarenoob.com"

RUN         apt-get update \
            && apt-get -y install --no-install-recommends git gcc g++ ca-certificates dnsutils curl iproute2 ffmpeg procps \
            && apt-get clean \
            && rm -rf /var/lib/apt/lists/* \
            && useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
