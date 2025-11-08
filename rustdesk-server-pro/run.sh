#!/usr/bin/with-contenv bashio

bashio::log.info "Starting RustDesk Server Pro..."

# Use /config for addon_config mapping
CONFIG_DIR="/config"

# Ensure config directory exists
mkdir -p "${CONFIG_DIR}"

bashio::log.info "Using config directory: ${CONFIG_DIR}"

# Start hbbr in background
bashio::log.info "Starting hbbr service..."
cd "${CONFIG_DIR}"
hbbr &
HBBR_PID=$!

# Start hbbs in foreground
bashio::log.info "Starting hbbs service..."
cd "${CONFIG_DIR}"

# Log the public key if it exists
if [ -f "${CONFIG_DIR}/id_ed25519.pub" ]; then
    bashio::log.info "Public Key: $(cat ${CONFIG_DIR}/id_ed25519.pub)"
else
    bashio::log.info "Public key will be generated on first start"
fi

hbbs

# If hbbs exits, kill hbbr
kill $HBBR_PID 2>/dev/null || true
