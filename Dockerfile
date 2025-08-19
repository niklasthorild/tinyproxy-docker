# Alpine Linux base image
FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache tzdata tinyproxy
    
# TCP port of Tinyproxy
EXPOSE 8888/tcp

# Run as a non-privileged user by default
USER 1000:1000

# Entrypoint
ENTRYPOINT ["tinyproxy"]
CMD ["-d", "-c", "/etc/tinyproxy/tinyproxy.conf"]
