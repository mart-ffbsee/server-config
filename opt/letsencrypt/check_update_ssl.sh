#!/bin/sh
service lighttpd stop
# TODO: use renew option in 0.4.0 letsencrypt clients here?
if ! /opt/letsencrypt/letsencrypt-auto certonly -tvv --email info@freifunk-ulm.de --agree-tos --standalone --keep -d $(hostname) > /var/log/letsencrypt/renew.log 2>&1 ; then
    echo Automated renewal failed:
    cat /var/log/letsencrypt/renew.log
    exit 1
fi
cat /etc/letsencrypt/live/$(hostname)/privkey.pem /etc/letsencrypt/live/$(hostname)/cert.pem > /etc/letsencrypt/live/$(hostname)/ssl.pem
service lighttpd start
