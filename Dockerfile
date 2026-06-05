# =========================
# Base image
# =========================
FROM alpine:3.14

MAINTAINER Iku Iwasa "iku.iwasa@gmail.com"

# =========================
# Alpine essentials
# =========================
RUN apk update && apk upgrade && \
    apk add --no-cache \
        ca-certificates \
        bash \
        coreutils \
        git \
        gnupg \
        rclone \
        sqlite \
        gcc \
        g++ \
        make \
        zlib-dev \
        ncurses-dev \
        libxml2-dev \
        wget \
        tar \
        xz \
        autoconf \
        automake \
        pkgconfig \
        texinfo \
        gtk+3.0-dev \
        gnutls-dev \
        jansson-dev \
        curl \
        curl-dev \
        bash-completion

# =========================
# Build Emacs 30.1 from source
# =========================
WORKDIR /tmp
RUN wget https://ftp.gnu.org/gnu/emacs/emacs-30.1.tar.gz && \
    tar -xzf emacs-30.1.tar.gz && \
    cd emacs-30.1 && \
    ./configure --with-native-compilation --with-json --with-modules --with-x-toolkit=no && \
    make -j$(nproc) && \
    make install

# Verify Emacs version
RUN /usr/local/bin/emacs --version

# =========================
# Create .emacs.d and copy your init
# =========================
WORKDIR /root
RUN mkdir -p /root/.emacs.d/packages
COPY init.el /root/.emacs.d/

# Optional: include htmlize as a local package
RUN git clone https://github.com/hniksic/emacs-htmlize.git /root/.emacs.d/packages/htmlize

# Copy other files
COPY --chmod=777 entrypoint.sh /
COPY publish.tar.gpg /root/

# =========================
# Entrypoint
# =========================
ENTRYPOINT ["/entrypoint.sh"]
CMD ["emacs"]
