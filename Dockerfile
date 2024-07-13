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

# git (future)
# RUN apk add git

# wget (future)
# RUN apk add wget

# Graphwiz
# RUN apk add graphviz

# Latex
# Package                    Archives  Disk Space
# -------------------------  --------  ----------
# texlive-latex-base            59 MB      216 MB
# texlive-latex-recommended     74 MB      248 MB
# texlive-pictures              83 MB      277 MB
# texlive-fonts-recommended     83 MB      281 MB
# texlive                       98 MB      314 MB
# texlive-plain-generic         82 MB      261 MB
# texlive-latex-extra          144 MB      452 MB
# texlive-full                2804 MB     5358 MB
# RUN apk add texlive-full
RUN apk add texlive-latex-base


WORKDIR /root

COPY init.el /root/.emacs.d/
COPY --chmod=777 entrypoint.sh /

RUN ls -lrt /

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "emacs" ]
