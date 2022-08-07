# must be pinned to older version for Forge support. @see https://github.com/MultiMC/Launcher/issues/4470#issuecomment-1025114255 and https://github.com/McModLauncher/modlauncher/issues/91
FROM        eclipse-temurin:8u312-b07-jdk-focal

LABEL       author="Softwarenoob" maintainer="admin@softwarenoob.com"

RUN apt-get update -y \
 && apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata iproute2 \
 && useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
