#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

INCLUDED_PACKAGES=($(jq -r "[(.all.include | (.all, select(.\"$SILVERBLUE_VERSION\" != null).\"$SILVERBLUE_VERSION\")[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".include | (.all, select(.\"$SILVERBLUE_VERSION\" != null).\"$SILVERBLUE_VERSION\")[])] \
                             | unique[]" /tmp/packages.json))
EXCLUDED_PACKAGES=($(jq -r "[(.all.exclude | (.all, select(.\"$SILVERBLUE_VERSION\" != null).\"$SILVERBLUE_VERSION\")[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".exclude | (.all, select(.\"$SILVERBLUE_VERSION\" != null).\"$SILVERBLUE_VERSION\")[])] \
                             | unique[]" /tmp/packages.json))


if [[ "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    EXCLUDED_PACKAGES=($(rpm -qa --queryformat='%{NAME} ' ${EXCLUDED_PACKAGES[@]}))
fi

# add repo's
# TODO - remove dockerpty rpm once there is a release for fedora 38 https://packages.fedoraproject.org/pkgs/python-dockerpty/python3-dockerpty/
# docker-pty is required for docker-compose
wget -P /tmp/rpms \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${RELEASE}.noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${RELEASE}.noarch.rpm \
    https://kojipkgs.fedoraproject.org//packages/python-dockerpty/0.4.1/26.fc37/noarch/python3-dockerpty-0.4.1-26.fc37.noarch.rpm


# install
rpm-ostree install \
    /tmp/rpms/*.rpm \
    fedora-repos-archive

if [[ "${#INCLUDED_PACKAGES[@]}" -gt 0 && "${#EXCLUDED_PACKAGES[@]}" -eq 0 ]]; then
    rpm-ostree install \
        ${INCLUDED_PACKAGES[@]}

elif [[ "${#INCLUDED_PACKAGES[@]}" -eq 0 && "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    rpm-ostree override remove \
        ${EXCLUDED_PACKAGES[@]}

elif [[ "${#INCLUDED_PACKAGES[@]}" -gt 0 && "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    rpm-ostree override remove \
        ${EXCLUDED_PACKAGES[@]} \
        $(printf -- "--install=%s " ${INCLUDED_PACKAGES[@]})

else
    echo "No packages to install."

fi