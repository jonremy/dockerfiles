# Usage example:
#  alias dotnet-shell='docker run --rm -it -v dotnet-sdk-home:/home/developer -v $PWD:/work -w /work -h dotnet jremy/dotnet-sdk bash'
#
FROM microsoft/dotnet:2.1-sdk

RUN apt-get -y update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libgomp1 \
 && rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG UNAME=developer
RUN useradd -m -s /bin/bash -u $UID $UNAME
USER $UNAME
WORKDIR /home/$UNAME
