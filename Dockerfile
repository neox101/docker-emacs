
# alpine:3.20 is stable for emacs 27.2
# FROM alpine:3.14
FROM alpine:3.20


MAINTAINER Iku Iwasa "iku.iwasa@gmail.com"

RUN apk update && apk upgrade

RUN apk add ca-certificates

RUN apk add gcc make g++ zlib-dev
RUN apk search sqlite
RUN apk add sqlite

RUN apk add coreutils

RUN apk add gnupg
RUN apk add rclone
# somehow this line did not work , but below line worked.
# RUN apk add git
RUN apk add --no-cache git

# below line working with alpine:3.14
RUN apk add emacs
# below line may work with alpine:3.20
# RUN apk add --no-cache emacs

WORKDIR /root

RUN mkdir /root/.emacs.d/
COPY init.el /root/.emacs.d/
RUN ls /root/.emacs.d/

COPY --chmod=777 entrypoint.sh /

COPY publish.tar.gpg /root/

RUN ls -lrt /
RUN ls -lrt /bin/
RUN which emacs
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "emacs" ]
