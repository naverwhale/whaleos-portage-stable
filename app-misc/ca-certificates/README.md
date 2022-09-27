app-misc/ca-certificates ebuild notes

This ebuild installs trusted CA certificates at `/etc/ssl/certs`, both
individually and as a concatenated PEM file at
`/etc/ssl/certs/ca-certificates.crt`. CA certificates are extracted
from the Mozilla NSS store. More details can be found at
the offical ChromeOS CA certificates [doc](https://chromium.googlesource.com/chromiumos/docs/+/HEAD/ca_certs.md#the-mozilla-nss-root-store)
