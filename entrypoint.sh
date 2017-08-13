#!/usr/bin/env sh

[ ! "$SOURCE_USER" ] && error "Must supply SOURCE_USER"
[ ! "$SOURCE_HOST" ] && error "Must supply SOURCE_HOST"
[ ! "$SOURCE_INTERFACE" ] && error "Must supply SOURCE_INTERFACE"

echo "Monitoring $SOURCE_INTERFACE from $SOURCE_USER@$SOURCE_HOST, filtering: $FILTER"

ssh -o StrictHostKeyChecking=no $SOURCE_USER@$SOURCE_HOST tcpdump -nn "$FILTER" -i $SOURCE_INTERFACE -w - | snort -c /etc/snort/snort.conf -A console -r -
