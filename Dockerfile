FROM node:20-slim

# Install OpenClaw globally
RUN npm install -g openclaw@latest

# Create necessary directories
RUN mkdir -p /root/.openclaw/workspace
RUN mkdir -p /root/.openclaw/cron

# Set working directory
WORKDIR /app

# Copy configuration files (we'll add these next)
COPY config/openclaw.json /root/.openclaw/openclaw.json
COPY config/jobs.json /root/.openclaw/cron/jobs.json

# Expose gateway port
EXPOSE 18789

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD openclaw gateway status || exit 1

# Start OpenClaw gateway
CMD ["openclaw", "gateway", "start"]