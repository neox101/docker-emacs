
FROM alpine:3.14

MAINTAINER Iku Iwasa "iku.iwasa@gmail.com"

RUN apk update && apk upgrade

RUN apk add ca-certificates

RUN apk add gcc make g++ zlib-dev

RUN apk search sqlite

RUN apk add sqlite

RUN apk add coreutils

RUN apk add gnupg

RUN apk add rclone

RUN apk add git

RUN apk add emacs


# create .emacs.d
WORKDIR /root
RUN mkdir /root/.emacs.d/
COPY init.el /root/.emacs.d/
RUN ls /root/.emacs.d/
COPY --chmod=777 entrypoint.sh /
COPY publish.tar.gpg /root/

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "emacs" ]
