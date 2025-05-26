#!/bin/sh

CERTBOT_CRON_SCHEDULE="${CERTBOT_CRON_SCHEDULE:-27 1 * * *}"

append_cron_schedule() {
    local schedule="$1"
    local line="$schedule certbot-renew"
    grep -qF "$line" $CRONTAB || echo "$line" >> $CRONTAB
}

echo "INFO Certbot CRON schedule is: $CERTBOT_CRON_SCHEDULE"

append_cron_schedule "@reboot"
append_cron_schedule "$CERTBOT_CRON_SCHEDULE"

