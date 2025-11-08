#!/usr/bin/with-contenv bashio

bashio::log.info "Starting RustDesk Server Pro..."

# Use /config for addon_config mapping
CONFIG_DIR="/config"

# Ensure config directory exists
mkdir -p "${CONFIG_DIR}"

bashio::log.info "Using config directory: ${CONFIG_DIR}"

# Find the RustDesk binaries
HBBR_BIN=$(which hbbr 2>/dev/null || find /usr -name hbbr 2>/dev/null | head -1 || echo "/hbbr")
HBBS_BIN=$(which hbbs 2>/dev/null || find /usr -name hbbs 2>/dev/null | head -1 || echo "/hbbs")

bashio::log.info "Found hbbr at: ${HBBR_BIN}"
bashio::log.info "Found hbbs at: ${HBBS_BIN}"

# Start hbbr in background
bashio::log.info "Starting hbbr service..."
cd "${CONFIG_DIR}"
"${HBBR_BIN}" &
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

"${HBBS_BIN}"

# If hbbs exits, kill hbbr
kill $HBBR_PID 2>/dev/null || true
