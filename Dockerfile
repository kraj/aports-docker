FROM alpine:edge

LABEL maintainer="raj.khem@gmail.com"

ENV APORTS /home/builder/aports 

# install required packages to build "alpine linux" packages
RUN apk add --update --no-cache --no-progress \
    alpine-sdk coreutils bash \
    sudo diffutils

# setup directory for built packages
RUN mkdir -p /var/cache/distfiles
RUN chmod a+w /var/cache/distfiles
RUN chgrp abuild /var/cache/distfiles
RUN chmod g+w /var/cache/distfiles

# setup the abuild configuration
RUN echo 'PACKAGER="Khem Raj <raj.khem@gmail.com>"' >> /etc/abuild.conf
RUN echo 'MAINTAINER="$PACKAGER"' >> /etc/abuild.conf
RUN echo "%abuild ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/abuild

# setup the build user in container
RUN adduser -D builder
RUN addgroup builder abuild

# setup directory to pass in build instructions files for abuild
VOLUME $APORTS
WORKDIR $APORTS
RUN chown builder:builder $APORTS

# make builder the current user in the image
USER builder

# create keys for signing packages after the build has been finished
RUN abuild-keygen -a -i -n

# setup git for the build user
RUN git config --global user.name "Khem Raj"
RUN git config --global user.email "raj.khem@gmail.com"

RUN git clone git://git.alpinelinux.org/aports $APORTS

