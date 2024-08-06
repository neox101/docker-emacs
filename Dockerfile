
# alpine3.14 gives emacs 27.2
# FROM alpine:3.14

# alpine3.20 gives emacs 29 
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




RUN apk add git
# RUN apk add --no-cache git
# Debugging
RUN which git



# below line working with alpine:3.14
RUN apk add emacs
# below line may work with alpine:3.20
# RUN apk add --no-cache emacs



# Debugging
RUN find / -name emacs
RUN ls -lrt /usr/bin/
RUN echo $PATH
RUN /usr/bin/emacs --version || true
RUN which emacs

# RUN ls -lrt /
# RUN ls -lrt /bin/



# create .emacs.d
WORKDIR /root
RUN mkdir /root/.emacs.d/
COPY init.el /root/.emacs.d/
RUN ls /root/.emacs.d/
COPY --chmod=777 entrypoint.sh /
COPY publish.tar.gpg /root/


ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "emacs" ]
