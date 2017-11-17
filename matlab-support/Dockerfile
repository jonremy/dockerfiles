# An image with enough dependencies to support a mounted-in matlab.
# Based on github.com/benjamin-heasly/matlab-support
#
# How to install (and activate) Matlab
# - Build the image with your host UID and the UNAME you want to use for Matlab
# - Generate a MAC address that will be associated with the license (write it somewhere)
#    export MATLAB_MAC="02:$(openssl rand -hex 5 | sed 's/\(..\)/\1:/g; s/.$//')"
# - Install Matlab. For example if the installer is in /tmp/matlab:
#    docker run --rm -it -v matlab:/usr/local/MATLAB --mac-address="$MATLAB_MAC" \
#        -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY \
#        -v /tmp/matlab:/media/installer \
#        -u root jremy/matlab-support bash
#    > cd /media/installer
#    > ./install
#    > cd /usr/local/MATLAB
#    > ln -s R20* current
#
# How to use it:
# - Example command (the volume for /home/$UNAME is not mandatory):
#    docker run --rm -it -v matlab:/usr/local/MATLAB --mac-address="$MATLAB_MAC" \
#        -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY \
#        -v matlab-home:/home/jon -v $PWD:/home/jon/workspace \
#        jremy/matlab-support matlab
#
FROM debian:8

# Matlab dependencies (xorg really ?)
RUN apt-get -y update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libpng12-dev \
        libfreetype6-dev \
        libblas-dev \
        liblapack-dev \
        gfortran \
        build-essential \
        xorg \
 && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/local/MATLAB/current/bin:${PATH}"

ARG UID=1000
ARG UNAME=jon
RUN useradd -m -s /bin/bash -u $UID $UNAME
USER $UNAME
WORKDIR /home/$UNAME

#ENTRYPOINT ["matlab", "-logfile /var/log/matlab/matlab.log"]
#CMD ["-h"]
