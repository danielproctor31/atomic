ARG FEDORA_MAJOR_VERSION=37
ARG SILVERBLUE_VERSION=silverblue

FROM quay.io/fedora-ostree-desktops/${SILVERBLUE_VERSION}:${FEDORA_MAJOR_VERSION}

ENV FEDORA_MAJOR_VERSION=FEDORA_MAJOR_VERSION
ENV SILVERBLUE_VERSION=SILVERBLUE_VERSION

# copy sys files
COPY files/etc /etc
COPY files/usr /usr

# copy installe files
COPY install.sh /tmp/install.sh
COPY packages.json /tmp/packages.json

# enable auto updates
RUN systemctl enable rpm-ostreed-automatic.timer

# run installer
RUN chmod u+x /tmp/install.sh
RUN /tmp/install.sh

# cleanup repo files
RUN rm -rf /tmp/*
RUN rm /etc/yum.repos.d/vscode.repo

# commit
RUN ostree container commit