FROM scalified/cron:1.37.0

LABEL maintainer="Scalified <scalified@gmail.com>"

RUN apk add --update --no-cache certbot \
    certbot-dns-cloudflare \
    docker-cli

RUN echo "CERTBOT VERSIONS: $(apk list | grep certbot)"

COPY init.d/ /init.d/
COPY usr/ /usr/

