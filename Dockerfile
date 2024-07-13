FROM alpine:3.20.1

MAINTAINER Iku Iwasa "iku.iwasa@gmail.com"

RUN apk update && apk upgrade
RUN apk add ca-certificates
RUN apk add emacs

RUN apk add gcc
RUN apk add make
RUN apk add g++
RUN apk add zlib-dev

RUN apk add coreutils
RUN apk add gnupg
RUN apk add wget
RUN apk add rclone


# RUN apk add sqlite

# RUN apk add git
# RUN apk add graphviz

# RUN apk search latex
# RUN apk search texlive
# RUN apk add texlive-full
# RUN apk add texlive

# Install python/pip
# ENV PYTHONUNBUFFERED=1
# RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
# RUN python3 -m ensurepip
# RUN pip3 install --no-cache --upgrade pip setuptools


WORKDIR /root

COPY init.el /root/.emacs.d/
COPY --chmod=777 entrypoint.sh /

RUN ls -lrt /
RUN ls -lrt /bin/

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "emacs" ]
