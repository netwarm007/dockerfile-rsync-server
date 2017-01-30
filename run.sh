#!/bin/bash
VOLUME=${VOLUME:-/data}
ALLOW=${ALLOW:-192.168.0.0/16 172.16.0.0/12}
OWNER=${OWNER:-nobody}
GROUP=${GROUP:-nogroup}

chown "${OWNER}:${GROUP}" "${VOLUME}"

[ -f /etc/rsyncd.conf ] || cat <<EOF > /etc/rsyncd.conf
uid = ${OWNER}
gid = ${GROUP}
use chroot = yes
log file = /dev/stdout
reverse lookup = no
[volume]
    hosts deny = *
    hosts allow = ${ALLOW}
    read only = false
    path = ${VOLUME}
    comment = docker volume
EOF

exec /usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf "$@"