# Use with:
#  alias pdftk='docker run --rm -v $PWD:/files -w /files -u $(id -u):$(id -g) jremy/pdftk pdftk'
#
FROM alpine

RUN apk add --no-cache pdftk

# This could be used to create an user in the container:
#RUN adduser -D -s /bin/sh -u $UID user

CMD pdftk --help
