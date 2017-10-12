# Pre-requisites:
#  - Sicstus install archive
#  - License information needed in install.cache
#
# Build with:
#  cp install.cache.template install.cache
#  vim install.cache
#  docker build --build-arg UID=$(id -u) -t jremy/sicstus .
#
# Use with:
#  alias sicstus='docker run --rm -v $PWD:/work -w /work -it jremy/sicstus bash -c "sleep .1; exec rlwrap sicstus \"\$@\";" --'
#
# Rlwrap is used because sicstus doesn't handle the arrow keys properly
# The sleep is here for rlwrap because of https://github.com/moby/moby/issues/25450

FROM debian:jessie AS build

RUN apt-get -y update \
 && apt-get install -y \
		build-essential \
 && rm -rf /var/lib/apt/lists/*

ARG ARCHIVE=sp-4.3.5-x86_64-linux-glibc2.17.tar.gz
COPY $ARCHVE install.cache /tmp/

RUN cd /tmp \
 && mkdir installer \
 && tar -xzvf $ARCHIVE --strip 1 -C installer \
 && cp install.cache installer/ \
 && cd installer \
 && yes '' | ./InstallSICStus



FROM debian:jessie

RUN apt-get -y update \
 && apt-get install -y \
		rlwrap \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/sicstus /opt/sicstus

RUN ln -s /opt/sicstus/bin/sicstus /usr/local/bin/sicstus

ARG UID=1000
RUN useradd -m -s /bin/bash -u $UID user
USER user

CMD sicstus --help
