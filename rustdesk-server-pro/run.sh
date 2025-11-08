#!/usr/bin/with-contenv bashio

bashio::log.info "Starting RustDesk Server Pro..."

# Use /config for addon_config mapping
CONFIG_DIR="/config"

# Ensure config directory exists
mkdir -p "${CONFIG_DIR}"

bashio::log.info "Using config directory: ${CONFIG_DIR}"

# RustDesk binaries are in /usr/bin
HBBR_BIN="/usr/bin/hbbr"
HBBS_BIN="/usr/bin/hbbs"

# Verify binaries exist
if [ ! -f "${HBBR_BIN}" ]; then
    bashio::log.error "hbbr not found at ${HBBR_BIN}"
    exit 1
fi

if [ ! -f "${HBBS_BIN}" ]; then
    bashio::log.error "hbbs not found at ${HBBS_BIN}"
    exit 1
fi

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
