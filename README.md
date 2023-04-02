# silverblue

Based on the work done in: https://github.com/ublue-os

This is my own custom image for Fedora Silverblue which can be used to quickly setup and new system to my preference and provide future updates.

**Currently i'm using [Kinoite](https://kinoite.fedoraproject.org/) so the build is setup to only build the kinoite variant. The silverblue package will not be updated. For any of the commands documented silverblue can be replaced by kinoite where applicable.**

## Usage

```
sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/danielproctor31/silverblue:latest
```

Depending on your current version, you may or may not need the --experimental flag.

It is recommended to [pin the deployment after](https://docs.fedoraproject.org/en-US/fedora-silverblue/faq/#_about_using_silverblue) the rebase and reboot so you can safely rollback.

## Nvidia

For Nvidia based systems, it is recommended to install the drivers manually and updating the kernel parameters after rebasing the system.

```
rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia
rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1 initcall_blacklist=simpledrm_platform_driver_init
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
