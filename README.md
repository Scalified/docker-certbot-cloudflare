# Certbot Cloudflare Docker Image

[![Release](https://img.shields.io/github/v/release/Scalified/docker-certbot-cloudflare?style=flat-square)](https://github.com/Scalified/docker-certbot-cloudflare/releases/latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/scalified/certbot-cloudflare.svg)](https://hub.docker.com/r/scalified/certbot-cloudflare)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/Scalified/docker-certbot-cloudflare/blob/master/LICENSE)

## Overview

[**Alpine**](https://www.alpinelinux.org/) [**Docker**](https://www.docker.com/) image with [**Certbot**](https://certbot.eff.org/) preconfigured to autorenew SSL certificates 
using [**Cloudflare**](https://www.cloudflare.com) DNS. Built on top of the [**Scalified CRON**](https://github.com/Scalified/docker-cron) image

[**Certbot**](https://certbot.eff.org/) is used in `certonly` mode and runs with the `--keep-until-expiring` flag, which ensures that an existing certificate is reused until it is 
within 30 days of expiration. A CRON job is configured to run Certbot at container startup and once daily at night, helping to ensure that SSL certificates are always up to date

## Usage

1. Generate a [Cloudflare User API Token](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/) with `Zone:DNS:Edit` permissions
2. Save the generated token in a [Cloudflare credentials](https://certbot-dns-cloudflare.readthedocs.io/en/stable/#credentials) file
3. Launch the `scalified/certbot-cloudflare` Docker image:

```bash
docker run \
    --name certbot \
    -e CF_EMAIL="admin@example.com" \
    -e CF_CREDENTIALS_FILE="/etc/certbot/cloudflare.ini" \
    -e CF_PROPAGATION_SECONDS="60" \
    -e DOMAINS="*.example.com example.com" \
    -e LETSENCRYPT_DIR="/etc/letsencrypt" \
    -e DEPLOY_HOOK="docker exec nginx nginx -s reload" \
    -e CERTBOT_CRON_SCHEDULE="27 1 * * *" \
    -v ./cloudflare.ini:/etc/certbot/cloudflare.ini:ro \
    -v ./letsencrypt:/etc/letsencrypt \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --detach \
    --restart always \
    scalified/certbot-cloudflare
```

| Environment Variable    | Description                                                                                     | Default Value                 |
|-------------------------|-------------------------------------------------------------------------------------------------|-------------------------------|
| `CF_EMAIL`              | Email address associated with **Cloudflare** account                                            |                               |
| `CF_CREDENTIALS_FILE`   | Path to the **Cloudflare** credentials file used for DNS authentication                         | `/etc/certbot/cloudflare.ini` |
| `CF_PROPAGATION_SECODS` | Number of seconds to wait for DNS propagation before requesting validation from the ACME server | `60`                          |
| `LETSENCRYPT_DIR`       | Directory where Certbot stores the generated Let's Encrypt SSL certificates                     | `/etc/letsencrypt`            |
| `DOMAINS`               | Space-separated list of domains for which SSL certificates should be generated                  |                               |
| `DEPLOY_HOOK`           | Shell command to run once per successfully issued certificate                                   |                               |
| `CERTBOT_CRON_SCHEDULE` | **CRON** expression that defines when to run the Certbot renewal                                | `27 1 * * *`                  |

## Scalified Links

* [Scalified](http://www.scalified.com)
* [Scalified Official Facebook Page](https://www.facebook.com/scalified)
* <a href="mailto:info@scalified.com?subject=[Docker Certbot Cloudflare]: Proposals And Suggestions">Scalified Support</a>

