#!/bin/bash
set -e

echo "[INFO] Starting RustDesk Server Pro..."

# Use /share/rustdesk for data persistence
DATA_DIR="/share/rustdesk"
mkdir -p "${DATA_DIR}"

echo "[INFO] Data directory: ${DATA_DIR}"

# Start hbbr in background
echo "[INFO] Starting hbbr service..."
cd "${DATA_DIR}"
/usr/bin/hbbr &
HBBR_PID=$!

# Give hbbr a moment to start
sleep 2

# Start hbbs in foreground
echo "[INFO] Starting hbbs service..."
cd "${DATA_DIR}"

# Log the public key if it exists
if [ -f "${DATA_DIR}/id_ed25519.pub" ]; then
    echo "[INFO] Public Key: $(cat ${DATA_DIR}/id_ed25519.pub)"
else
    echo "[INFO] Public key will be generated on first start"
fi

/usr/bin/hbbs

# If hbbs exits, kill hbbr
kill $HBBR_PID 2>/dev/null || true
