FROM        amazoncorretto:8

LABEL       author="Softwarenoob" maintainer="admin@softwarenoob.com"
LABEL       org.opencontainers.image.source="https://github.com/Software-Noob/pterodactyl-images"
LABEL       org.opencontainers.image.licenses="MIT"

RUN         yum upgrade -y \
            && yum install -y curl ca-certificates openssl git tar sqlite fontconfig freetype libstdc++.so.6 freetype-devel lsof build-essential tzdata iproute \
            git gcc gcc-c++ automake make libtool \
            && yum clean all \
            && rm -rf /var/cache/yum \
            && useradd -m -d /home/container container

ENV         LC_ALL=en_US.UTF-8
ENV         LANG=en_US.UTF-8
ENV         LANGUAGE=en_US.UTF-8

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
