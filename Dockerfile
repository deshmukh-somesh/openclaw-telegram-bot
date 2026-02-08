FROM node:20-slim

# Install OpenClaw globally
RUN npm install -g openclaw@latest

# Create app user for security (avoid running as root)
RUN useradd -m -u 1001 openclaw

# Create necessary directories with proper permissions
RUN mkdir -p /home/openclaw/.openclaw/workspace && \
    mkdir -p /home/openclaw/.openclaw/cron && \
    chown -R openclaw:openclaw /home/openclaw/.openclaw

# Set working directory
WORKDIR /app

# Copy configuration files
COPY --chown=openclaw:openclaw config/openclaw.json /home/openclaw/.openclaw/openclaw.json
COPY --chown=openclaw:openclaw config/jobs.json /home/openclaw/.openclaw/cron/jobs.json

# Switch to non-root user
USER openclaw

# Expose gateway port
EXPOSE 18789

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD openclaw gateway status || exit 1

# Start OpenClaw gateway
CMD ["openclaw", "gateway", "start"]