#!/bin/sh
# Official RustDesk setup: volumes map to /root, run from /root
# Ref: https://rustdesk.com/docs/en/self-host/rustdesk-server-pro/installscript/docker/

cd /root

# Start hbbr in background (as per official docker-compose)
hbbr &

# Start hbbs in foreground (as per official docker-compose)
hbbs
