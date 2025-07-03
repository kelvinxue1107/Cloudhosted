# ---- Build Stage ----
# Use the official v2fly-core image as a source for the binaries.
# Pinning to a specific version is recommended for reproducible builds.
FROM v2fly/v2fly-core:v5.15.0 AS builder

# ---- Runtime Stage ----
# Use a minimal, secure base image. Alpine is a good choice for its small size.
FROM alpine:3.19

# Label the image with maintainer and version information for better management.
LABEL maintainer="kelvin.xue@outlook.com"
LABEL version="1.0.0"

# Create a non-root user and group for running the application.
# Running as a non-root user is a critical security best practice.
RUN addgroup -S v2ray && adduser -S -G v2ray v2ray

# Copy only the essential binaries from the builder stage.
# This minimizes the final image size and attack surface.
COPY --from=builder /usr/bin/v2ray /usr/bin/v2ray
COPY --from=builder /usr/bin/v2ctl /usr/bin/v2ctl

# Copy the GeoIP and GeoSite data files, which are required for routing rules.
COPY --from=builder /usr/share/v2ray/geoip.dat /usr/share/v2ray/geoip.dat
COPY --from=builder /usr/share/v2ray/geosite.dat /usr/share/v2ray/geosite.dat

# Create the directory for the configuration file and certificates.
# Set ownership to the non-root user.
RUN mkdir -p /etc/v2ray/certs && \
    chown -R v2ray:v2ray /etc/v2ray && \
    chown -R v2ray:v2ray /usr/share/v2ray

# Designate the configuration directory as a volume. This allows the configuration
# to be mounted from an external source (like a Kubernetes ConfigMap) at runtime.
VOLUME /etc/v2ray

# Switch to the non-root user.
USER v2ray

# Expose the port that the V2Ray service will listen on.
# This should match the port configured in config.json.
EXPOSE 443

# Set the default command to run when the container starts.
# It launches V2Ray, pointing it to the configuration file that will be mounted.
CMD ["/usr/bin/v2ray", "run", "-config", "/etc/v2ray/config.json"]