# Build with:
#  docker build --build-arg UID=$(id -u) -t jremy/pdftk .
# Use with:
#  alias pdftk='docker run --rm -v $PWD:/files jremy/pdftk pdftk'

FROM alpine

RUN apk update \
 && apk upgrade \
 && apk add pdftk

ARG UID=1000
RUN adduser -D -s /bin/sh -u $UID user \
 && mkdir /files
USER user
WORKDIR /files
VOLUME /files

CMD pdftk --help
