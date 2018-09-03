# To build with local user id:
#  sudo docker build -t jremy/qasm2circ --build-arg UID=$(id -u) .
# Use with:
#  alias qasm2png='docker run --rm -v qasm2circ-cache:/home/developer -v $PWD:/work -w /work jremy/qasm2circ qasm2 png'
#
FROM ubuntu:18.04

# Install MiKTeX: https://miktex.org/howto/install-miktex-unx
RUN apt-get -y update \
 && apt-get -y install apt-transport-https ca-certificates gnupg \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889 \
 && echo "deb http://miktex.org/download/ubuntu bionic universe" > /etc/apt/sources.list.d/miktex.list \
 && apt-get -y update \
 && apt-get install -y miktex
#&& rm -rf /var/lib/apt/lists/*

# Configure MiKTeX: https://hub.docker.com/r/miktex/miktex/~/dockerfile/
RUN initexmf --admin --force --mklinks \
 && mpm --admin --install amsfonts \
 && initexmf --admin --mkmaps \
 && initexmf --admin --update-fndb

# Other packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
		python2.7 \
		ghostscript \
		netpbm \
		csh \
		curl \
		sudo

# Install qasm2circ
RUN curl -fL# -o /tmp/qasm2circ.tgz "https://www.media.mit.edu/quanta/qasm2circ/qasm2circ-v1.4.tgz" \
 && mkdir -p /opt/qasm2circ \
 && cd /opt/qasm2circ \
 && tar -xzvf /tmp/qasm2circ.tgz --strip 1 \
 && rm -f /tmp/qasm2circ.tgz \
 && ln -s $(which python2.7) /usr/local/bin/python

ADD qasm2 /usr/local/bin/

# Create user
ARG UID=1000
RUN useradd -m -s /bin/bash -u $UID developer \
 && echo developer "ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/developer
USER developer
