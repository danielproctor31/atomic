# silverblue

Based on the work done in: https://github.com/ublue-os

This is my own custom image for Fedora Silverblue which can be used to quickly setup and new system to my preference and provide future updates.

## Usage

```
sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/danielproctor31/silverblue:latest
```

Depending on your current version, you may or may not need the --experimental flag.

It is recommended to [pin the deployment after](https://docs.fedoraproject.org/en-US/fedora-silverblue/faq/#_about_using_silverblue) the rebase and reboot so you can safely rollback.

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
