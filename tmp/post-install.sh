#!/bin/sh

set -ouex pipefail

# enable auto updates
systemctl enable rpm-ostreed-automatic.timer
systemctl enable flatpak-system-update.timer
systemctl --global enable flatpak-user-update.timer
systemctl --global enable distrobox-update.timer

# enable dconf update
systemctl unmask dconf-update.service
systemctl enable dconf-update.service