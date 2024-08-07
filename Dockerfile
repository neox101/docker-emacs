
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


# ###### Effort 3
FROM silex/emacs:25.1

RUN apk add --no-cache git make emacs

# RUN apt-get update && \
#     apt-get install -y git make && \
#     rm -rf /var/lib/apt/lists/*



# ###### Effort 2
# # Install Emacs
# RUN apk add --no-cache emacs
# 
# # Debugging
# RUN apk info -L emacs
# RUN find / -name emacs
# RUN ls -lrt /usr/lib/emacs
# RUN ls -lrt /usr/share/emacs
# RUN ls -lrt /var/games/emacs
# Create symlink if necessary
# Uncomment if you find emacs in a different location
# RUN ln -s /path/to/found/emacs /usr/bin/emacs
# Test if emacs can be found and is executable
# RUN /usr/bin/emacs --version || true
# 
# RUN /usr/lib/emacs --version || true
# RUN /usr/share/emacs --version || true
# RUN /var/games/emacs --version || true


###### Effort 1
# RUN echo PATH=$PATH
# 
# # Before installation:
# RUN apk info -L emacs
# RUN find / -name emacs
# 
# # search Emacs
# RUN apk search emacs
# # below line working with alpine:3.14
# RUN apk add emacs
# 
# # After installation:
# RUN apk info -L emacs
# RUN find / -name emacs
# 
# 
# 
# 
# # verify package integrity
# RUN apk del emacs && apk add --no-cache emacs
# 
# # Before installation 2:
# RUN apk info -L emacs
# RUN find / -name emacs
# 
# RUN /usr/share/emacs --version || true
# 
# RUN ln -s /usr/share/emacs /usr/bin/emacs
# 
# # RUN ls -lrt /usr/lib/emacs
# # RUN ls -lrt /usr/bin/emacs
# 
# # RUN /usr/bin/emacs --version || true
# # RUN which emacs
# # RUN ls -lrt /
# # RUN ls -lrt /bin/



# create .emacs.d
WORKDIR /root
RUN mkdir /root/.emacs.d/
COPY init.el /root/.emacs.d/
RUN ls /root/.emacs.d/
COPY --chmod=777 entrypoint.sh /
COPY publish.tar.gpg /root/


ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "emacs" ]
