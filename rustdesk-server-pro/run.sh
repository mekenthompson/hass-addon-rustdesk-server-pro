#!/usr/bin/with-contenv bashio

bashio::log.info "Starting RustDesk Server Pro..."

# RustDesk expects data in /root (per official Docker documentation)
# Home Assistant maps addon_config to /config, so we symlink /root to /config
CONFIG_DIR="/config"
RUSTDESK_DIR="/root"

# Ensure config directory exists
mkdir -p "${CONFIG_DIR}"

# Create symlink if /root is not already /config
if [ ! -L "${RUSTDESK_DIR}" ] && [ "${RUSTDESK_DIR}" != "${CONFIG_DIR}" ]; then
    # Backup original /root if it exists and has content
    if [ -d "${RUSTDESK_DIR}" ] && [ "$(ls -A ${RUSTDESK_DIR})" ]; then
        bashio::log.warning "Moving existing /root to /root.bak"
        mv "${RUSTDESK_DIR}" "${RUSTDESK_DIR}.bak"
    else
        rm -rf "${RUSTDESK_DIR}"
    fi
    ln -sf "${CONFIG_DIR}" "${RUSTDESK_DIR}"
    bashio::log.info "Linked ${RUSTDESK_DIR} -> ${CONFIG_DIR}"
fi

bashio::log.info "Using data directory: ${RUSTDESK_DIR} (mapped to ${CONFIG_DIR})"

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

# Start hbbr in background (runs from /root per RustDesk docs)
bashio::log.info "Starting hbbr service..."
cd "${RUSTDESK_DIR}"
"${HBBR_BIN}" &
HBBR_PID=$!

# Start hbbs in foreground (runs from /root per RustDesk docs)
bashio::log.info "Starting hbbs service..."
cd "${RUSTDESK_DIR}"

# Log the public key if it exists
if [ -f "${RUSTDESK_DIR}/id_ed25519.pub" ]; then
    bashio::log.info "Public Key: $(cat ${RUSTDESK_DIR}/id_ed25519.pub)"
else
    bashio::log.info "Public key will be generated on first start"
fi

"${HBBS_BIN}"

# If hbbs exits, kill hbbr
kill $HBBR_PID 2>/dev/null || true
