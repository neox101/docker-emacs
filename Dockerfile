FROM alpine:3.20.1

MAINTAINER Iku Iwasa "iku.iwasa@gmail.com"

RUN apk update && apk upgrade
RUN apk add ca-certificates
RUN apk add emacs
RUN apk add gcc make g++ zlib-dev
RUN apk search sqlite
RUN apk add sqlite

RUN apk add coreutils

RUN apk add gnupg

RUN apk add git
RUN apk add wget
RUN apk add graphviz
RUN apk add python3-pip
RUN apk add texlive-full


WORKDIR /root

COPY init.el /root/.emacs.d/
COPY --chmod=777 entrypoint.sh /

RUN ls -lrt /

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "emacs" ]
