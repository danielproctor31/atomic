# atomic

Based on the work done in: https://github.com/ublue-os

This is my own image for [Fedora Atomic Desktops](https://fedoraproject.org/atomic-desktops/) which can be used to quickly setup and new system to my preference and provide future updates.

## Usage

```
sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/danielproctor31/silverblue:latest
```

Depending on your current version, you may or may not need the --experimental flag.

### Deployment Pinning

It is recommended to [pin the deployment after](https://docs.fedoraproject.org/en-US/fedora-silverblue/faq/#_about_using_silverblue) the rebase and reboot so you can safely rollback.

### Flatpak and Web Browser

By default there is no web browser. I recommend setting up the Flathub Repository for Flatpak and installing Firefox.

```
# Add flathub repo at the system and user level
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Firefox at the system level
flatpak install flathub org.mozilla.firefox
```

## Nvidia

For Nvidia based systems, it is recommended to install the drivers manually and updating the kernel parameters after rebasing the system.

```
sudo rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia
sudo rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1 initcall_blacklist=simpledrm_platform_driver_init
```

References:
- https://rpmfusion.org/Howto/NVIDIA#OSTree_.28Silverblue.2FKinoite.2Fetc.29

## Verification
This image is signed with [sisgstore's cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the cosign.pub key from this repo and running the following command:

```
cosign verify --key cosign.pub ghcr.io/danielproctor31/silverblue
```

## Testing locally

The container can be built with Podman:
```
podman build -f Containerfile .
```
