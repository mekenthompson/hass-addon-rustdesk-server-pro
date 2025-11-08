FROM rustdesk/rustdesk-server-pro:latest

# Install bash for Home Assistant s6 integration
RUN apk add --no-cache bash 2>/dev/null || \
    apt-get update && apt-get install -y bash 2>/dev/null || true

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Use the original entrypoint but override CMD
ENTRYPOINT []
CMD ["/run.sh"]
