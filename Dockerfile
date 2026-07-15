FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl unzip ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Download phoenixd directly from official ACINQ GitHub release
# (the sethforprivacy image is abandoned at v0.6.0)
ARG PHOENIXD_VERSION=0.9.0
ENV PHOENIXD_VERSION=${PHOENIXD_VERSION}
RUN curl -fSL "https://github.com/ACINQ/phoenixd/releases/download/v${PHOENIXD_VERSION}/phoenixd-${PHOENIXD_VERSION}-linux-x64.zip" -o /tmp/phoenixd.zip && \
    unzip /tmp/phoenixd.zip -d /opt && \
    rm /tmp/phoenixd.zip && \
    chmod +x /opt/phoenixd-${PHOENIXD_VERSION}-linux-x64/phoenixd

# Run as root — required for writing to the Railway volume mount at /root/.phoenix
USER root

ENTRYPOINT []
CMD ["/bin/sh", "-c", "exec /opt/phoenixd-${PHOENIXD_VERSION}-linux-x64/phoenixd --agree-to-terms-of-service --http-bind-ip 0.0.0.0 --http-password $PHOENIX_PASSWORD"]
