# silverblue

https://github.com/ublue-os

## Usage
```
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/danielproctor31/silverblue:latest
```

Depending on the version, you may or may not need the --experimental flag.
```
sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/danielproctor31/silverblue:latest
```

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
