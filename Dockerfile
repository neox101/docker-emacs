FROM alpine:3.20.0
# FROM alpine:3.12

MAINTAINER Iku Iwasa "iku.iwasa@gmail.com"

RUN apk update && apk upgrade
RUN apk add ca-certificates emacs
RUN apk add gcc make g++ zlib-dev
RUN apk search sqlite
RUN apk add sqlite

RUN apk add coreutils

RUN apk add gnupg
RUN apk add rclone

WORKDIR /root

COPY init.el /root/.emacs.d/
COPY --chmod=777 entrypoint.sh /

# RUN ls -lrt /
# RUN ls -lrt /bin/
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "emacs" ]
