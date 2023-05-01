#!/bin/sh

set -ouex pipefail

# install fonts
mkdir /usr/share/fonts/nerd-fonts
curl -fLo "/usr/share/fonts/nerd-fonts/CaskaydiaCoveNerdFont.ttf" \
    https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/CascadiaCode/Regular/CaskaydiaCoveNerdFont-Regular.ttf
curl -fLo "/usr/share/fonts/nerd-fonts/CaskaydiaCoveNerdFontMono-Regular.ttf" \
    https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/CascadiaCode/Regular/CaskaydiaCoveNerdFontMono-Regular.ttf

fc-cache -f /usr/share/fonts/nerd-fonts

# enable auto updates
systemctl enable rpm-ostreed-automatic.timer
systemctl enable flatpak-system-update.timer
systemctl --global enable flatpak-user-update.timer
systemctl --global enable distrobox-update.timer
