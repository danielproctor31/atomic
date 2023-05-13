#!/bin/sh

set -ouex pipefail

# enable auto updates
systemctl enable rpm-ostreed-automatic.timer
systemctl enable flatpak-system-update.timer
systemctl --global enable flatpak-user-update.timer
systemctl --global enable distrobox-update.timer

if [ $SILVERBLUE_VERSION = "silverblue" ]; then
  # enable dconf update
  systemctl unmask dconf-update.service
  systemctl enable dconf-update.service
else
  # remove gnome specific items
  rm /etc/systemd/system/dconf-update.service
  rm -r /usr/share/fonts/Ubuntu
  rm -r /usr/share/fonts/Ubuntu_Mono
fi
