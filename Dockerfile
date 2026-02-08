FROM node:20-slim

# Install OpenClaw
RUN npm install -g openclaw

# Create directories
RUN mkdir -p /root/.openclaw/workspace

# Set working directory
WORKDIR /app

# Copy your local config (optional)
# COPY .openclaw/openclaw.json /root/.openclaw/openclaw.json
# COPY .openclaw/workspace/ /root/.openclaw/workspace/

# Expose gateway port
EXPOSE 18789

# Start OpenClaw
CMD ["openclaw", "gateway"]