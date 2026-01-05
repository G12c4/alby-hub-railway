FROM ghcr.io/sethforprivacy/phoenixd:latest

# 1. Switch to root to fix the "Permission Denied" errors on Railway volumes
USER root

# 2. CLEAR the default entrypoint so it doesn't force-start phoenixd
ENTRYPOINT []

# 3. Use a shell to find and run phoenixd with your password
CMD ["/bin/sh", "-c", "exec $(find / -name phoenixd -type f -executable | head -n 1) --agree-to-terms-of-service --http-bind-ip 0.0.0.0 --http-password $PHOENIX_PASSWORD"]
