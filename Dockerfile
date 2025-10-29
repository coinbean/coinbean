# Coinbean - Dockerfile
# A comprehensive cryptocurrency portfolio tracking system built on Beancount

FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Beancount and Fava
RUN pip install --no-cache-dir \
    beancount \
    fava \
    requests

# Copy project files
COPY . .

# Expose Fava port
EXPOSE 5002

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5002/ || exit 1

# Default command: validate ledger and start Fava
CMD ["sh", "-c", "bean-check crypto_main.beancount && fava -H 0.0.0.0 -p 5002 --poll-watcher crypto_main.beancount"]
