ARG BUILD_FROM=rustdesk/rustdesk-server-pro:latest
FROM ${BUILD_FROM}

# Install bashio for Home Assistant integration
RUN apk add --no-cache bash || true

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
