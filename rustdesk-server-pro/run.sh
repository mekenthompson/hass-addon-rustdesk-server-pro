#!/bin/sh
# Official RustDesk setup: volumes map to /root, run from /root
# Ref: https://rustdesk.com/docs/en/self-host/rustdesk-server-pro/installscript/docker/

# Home Assistant maps config to /config, but RustDesk expects /root
# Mount /config as /root for data persistence
if [ ! -L /root ] || [ "$(readlink /root)" != "/config" ]; then
    rm -rf /root
    ln -s /config /root
fi

cd /root

# Start hbbr in background (as per official docker-compose)
hbbr &

# Start hbbs in foreground (as per official docker-compose)
hbbs
