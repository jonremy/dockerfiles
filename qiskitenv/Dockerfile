# Docker image with dependencies needed by the QISKit
#
# To build with local user name and id:
#  sudo docker build -t jremy/qiskitenv --build-arg UID=$(id -u) --build-arg UNAME=$(id -un) .
# Start with:
#  docker run --rm -it -h qiskitenv -v qiskitenv-home:/home/$(id -un) jremy/qiskitenv
#
FROM debian:9

# Install MiKTeX: https://miktex.org/howto/install-miktex-unx
RUN apt-get -y update \
 && apt-get -y install apt-transport-https gnupg \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889 \
 && echo "deb http://miktex.org/download/debian stretch universe" > /etc/apt/sources.list.d/miktex.list \
 && apt-get -y update \
 && apt-get install -y perl miktex
#&& rm -rf /var/lib/apt/lists/*

# Configure MiKTeX: https://hub.docker.com/r/miktex/miktex/~/dockerfile/
RUN initexmf --admin --force --mklinks \
 && mpm --admin --install amsfonts \
 && initexmf --admin --mkmaps \
 && initexmf --admin --update-fndb

# Other packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
		sudo \
		screen \
		python3-pip \
		python3-venv \
		poppler-utils

# Create user
ARG UID=1000
ARG UNAME=developer
RUN useradd -m -s /bin/bash -u $UID $UNAME \
 && echo $UNAME "ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER $UNAME
WORKDIR /home/$UNAME
