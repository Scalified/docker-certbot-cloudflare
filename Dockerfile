FROM scalified/cron

LABEL maintainer="Scalified <scalified@gmail.com>"

RUN apk add --update --no-cache certbot \
    certbot-dns-cloudflare \
    docker-cli

RUN echo "CERTBOT VERSIONS: $(apk list | grep certbot)"

COPY rootfs /
