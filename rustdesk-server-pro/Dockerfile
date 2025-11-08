FROM rustdesk/rustdesk-server-pro:latest

# Remove /root so we can replace it with a mount point
RUN rm -rf /root && mkdir -p /root

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
