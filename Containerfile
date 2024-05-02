ARG FEDORA_MAJOR_VERSION=40
ARG VARIANT=silverblue

FROM quay.io/fedora-ostree-desktops/${VARIANT}:${FEDORA_MAJOR_VERSION}

ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION}"
ARG VARIANT="${VARIANT}"

# copy sys files
COPY files/etc /etc
COPY files/usr /usr

# copy install files
COPY tmp tmp

# run installer
RUN chmod +x /tmp/install.sh && \
    /tmp/install.sh
    
# run post install
RUN chmod +x /tmp/post-install.sh && \
    /tmp/post-install.sh

# cleanup
RUN rm -rf \
    /tmp/* \
    /var/* \
    /etc/yum.repos.d/vscode.repo \
    /etc/yum.repos.d/starship.repo \
    /etc/yum.repos.d/docker-ce.repo

# commit
RUN ostree container commit
