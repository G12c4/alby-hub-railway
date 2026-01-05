FROM ghcr.io/sethforprivacy/phoenixd:latest

# Force the container to run as Root so it can write to the Railway Volume
USER root

# Run the node with your password and settings
CMD ["/bin/sh", "-c", "exec $(find / -name phoenixd -type f -executable | head -n 1) --agree-to-terms-of-service --http-bind-ip 0.0.0.0 --http-password $PHOENIX_PASSWORD"]
