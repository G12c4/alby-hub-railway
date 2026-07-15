FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl unzip ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Download phoenixd directly from official ACINQ GitHub release
ARG PHOENIXD_VERSION=0.9.0
RUN curl -fSL "https://github.com/ACINQ/phoenixd/releases/download/v${PHOENIXD_VERSION}/phoenixd-${PHOENIXD_VERSION}-linux-x64.zip" -o /tmp/phoenixd.zip && \
    unzip /tmp/phoenixd.zip -d /opt/phoenixd && \
    rm /tmp/phoenixd.zip && \
    chmod +x /opt/phoenixd/bin/phoenixd

ENTRYPOINT []
CMD ["/bin/sh", "-c", "exec /opt/phoenixd/bin/phoenixd --agree-to-terms-of-service --http-bind-ip 0.0.0.0 --http-password $PHOENIX_PASSWORD"]
