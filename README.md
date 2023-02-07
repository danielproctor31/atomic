# ublue-image

https://github.com/ublue-os

On a fresh install of Fedora Silverblue, run:

```
sudo rpm-ostree --experimental ostree-unverified-registry:ghcr.io/danielproctor31/ublue-image:latest
```

## Testing locally

The container can be built with Docker:
```
docker build -f Containerfile .
```