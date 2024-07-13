FROM nixos/nix

ADD https://api.github.com/repos/purcell/nix-emacs-ci/git/refs/heads/master /tmp/cache
RUN echo 'extra-experimental-features = flakes nix-command' >> /etc/nix/nix.conf
RUN nix profile install --impure --accept-flake-config "github:purcell/nix-emacs-ci#emacs-29-1"
RUN nix copy --no-require-sigs --to /nix-emacs $(type -p emacs)
RUN cd /nix-emacs/nix/store && ln -s *emacs* emacs

FROM alpine:3.14
RUN apk add --no-cache \
            curl \
            gnupg \
            openssh-client \
            wget
            
RUN ls /nix-emacs/nix/store
COPY --from=0 /nix-emacs/nix/store /nix/store
RUN ls /nix/store
RUN ls /nix/store/emacs/bin
ENV PATH="/nix/store/emacs/bin:$PATH"


FROM alpine:3.14
# FROM alpine:3.13
# FROM alpine:3.12

MAINTAINER Iku Iwasa "iku.iwasa@gmail.com"

RUN apk update && apk upgrade

RUN apk add ca-certificates
# RUN apk add emacs
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
