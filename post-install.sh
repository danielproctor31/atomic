#!/bin/sh

set -ouex pipefail

# install fonts
mkdir /usr/share/fonts/nerd-fonts
curl -fLo "/usr/share/fonts/nerd-fonts/Caskaydia_Cove_Nerd_Font_Complete_Regular.otf" \
    https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/CascadiaCode/Regular/complete/Caskaydia%20Cove%20Nerd%20Font%20Complete%20Regular.otf
curl -fLo "/usr/share/fonts/nerd-fonts/Caskaydia_Cove_Nerd_Font_Complete_Mono_Regular.otf" \
    https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/CascadiaCode/Regular/complete/Caskaydia%20Cove%20Nerd%20Font%20Complete%20Mono%20Regular.otf

fc-cache -f /usr/share/fonts/nerd-fonts

# enable auto updates
systemctl enable rpm-ostreed-automatic.timer
systemctl enable flatpak-system-update.timer
systemctl --global enable flatpak-user-update.timer
systemctl --global enable distrobox-update.timer
