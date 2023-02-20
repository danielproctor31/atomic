ARG FEDORA_MAJOR_VERSION=37

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_MAJOR_VERSION}

COPY etc /etc

RUN sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

RUN rpm-ostree override remove firefox firefox-langpacks && \
    # Enable repo's.
    rpm-ostree install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    # Install packages.
    rpm-ostree install vim zsh steam-devices wireguard-tools distrobox code docker docker-compose gnome-tweaks && \
    # Enable auto updates
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    systemctl enable flatpak-automatic.timer && \
    systemctl enable distrobox-automatic.timer && \
    # Commit.
    ostree container commit

# cleanup
RUN rm -rf /etc/yum.repos.d/vscode.repo