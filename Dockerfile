FROM alpine:3.17

MAINTAINER Iku Iwasa "iku.iwasa@gmail.com"

RUN apk update && apk upgrade
RUN apk add ca-certificates emacs
RUN apk add gcc make g++ zlib-dev
RUN apk search sqlite
RUN apk add sqlite

RUN apk add coreutils

RUN apk add gnupg

WORKDIR /root

COPY init.el /root/.emacs.d/

COPY --chown=1000:1000 --chmod=777 entrypoint.sh /

ENTRYPOINT [ "sh", "/entrypoint.sh" ]
CMD [ "emacs" ]
