# Pre-requisites:
#  - Sicstus install archive (*.tar.gz)
#  - License information needed in install.cache
#
# Build with:
#  cp install.cache.template install.cache
#  vim install.cache
#  docker build --build-arg UID=$(id -u) -t jremy/sicstus .
#
# Use with:
#  alias sicstus='docker run --rm -v $PWD:/work -w /work -it jremy/sicstus sicstusw'
#
FROM debian:9 AS build

RUN apt-get -y update \
 && apt-get install -y \
		build-essential \
 && rm -rf /var/lib/apt/lists/*

COPY *.tar.gz install.cache /tmp/

RUN cd /tmp \
 && ARCHIVE=$(ls *.tar.gz | tail -n 1) \
 && echo "Using archive $ARCHIVE" \
 && mkdir installer \
 && tar -xzvf $ARCHIVE --strip 1 -C installer \
 && cp install.cache installer/ \
 && cd installer \
 && yes '' | ./InstallSICStus



FROM debian:9

RUN apt-get -y update \
 && apt-get install -y \
		rlwrap \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/sicstus /opt/sicstus
COPY sicstusw /usr/local/bin/

RUN ln -s /opt/sicstus/bin/sicstus /usr/local/bin/sicstus \
 && chmod +x /usr/local/bin/sicstusw

ARG UID=1000
RUN useradd -m -s /bin/bash -u $UID user
USER user

CMD sicstus --help
