ARG FEDORA_MAJOR_VERSION=37
ARG SILVERBLUE_VERSION=silverblue

FROM quay.io/fedora-ostree-desktops/${SILVERBLUE_VERSION}:${FEDORA_MAJOR_VERSION}

ENV FEDORA_MAJOR_VERSION=FEDORA_MAJOR_VERSION
ENV SILVERBLUE_VERSION=SILVERBLUE_VERSION

# copy sys files
COPY files/etc /etc
COPY files/usr /usr

# copy install files
COPY install.sh /tmp/install.sh
COPY packages.json /tmp/packages.json

# run installer
RUN chmod +x /tmp/install.sh
RUN /tmp/install.sh

# cleanup repo files
RUN rm -rf /tmp/*
RUN rm /etc/yum.repos.d/vscode.repo
RUN rm /etc/yum.repos.d/starship.repo

# Fix for fedora 38 - Remove leftover unbound files
# TODO - check this is still needed once fedora 38 is officially released
RUN rm -rf /var/lib/unbound

# commit
RUN ostree container commit
