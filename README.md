# ublue-image

https://github.com/ublue-os

## Usage
```
sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/danielproctor31/ublue-image:latest
```

## Auth
If you are building images using a private repo, authentication is required.

Create a personal access token with `read:packages` permission: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

The config file needs to be created at `/etc/ostree/auth.json`. As the auth needs to be in base64 - it can be generated using Podman and copied over.
```
podman login ghcr.io
```
Enter your github username and the personal access token as the password.

Copy the generated config file to `/etc/ostree/auth.json`.

```
sudo cp ${XDG_RUNTIME_DIR}/containers/auth.json /etc/ostree/auth.json
```

References:
- https://github.com/containers/image/blob/main/docs/containers-auth.json.5.md
- https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry

## Testing locally

The container can be built with Podman:
```
podman build -f Containerfile .
```
