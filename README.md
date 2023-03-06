# silverblue

Based on the work done in: https://github.com/ublue-os
This is my own custom image for Fedora Silverblue which can be used to quickly setup and new system to my preference and provide future updates.

## Usage

### Silverblue
```
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/danielproctor31/silverblue:latest
```

### Kinoite
```
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/danielproctor31/kinoite:latest
```

Depending on the version, you may or may not need the --experimental flag.
```
sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/danielproctor31/silverblue:latest
```

## Verification
This image is signed with [sisgstore's cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the cosign.pub key from this repo and running the following command:

```
cosign verify --key cosign.pub ghcr.io/danielproctor31/silverblue
cosign verify --key cosign.pub ghcr.io/danielproctor31/kinoite
```

## Testing locally

The container can be built with Podman:
```
podman build -f Containerfile .
```
