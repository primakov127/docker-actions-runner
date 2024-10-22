# Use a lightweight Linux base image
FROM ubuntu:22.04

# Set environment variable to avoid prompts during apt-get install
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    sudo \
    jq \
    git \
    libicu-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    wget \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for the GitHub Actions runner
RUN mkdir /actions-runner
WORKDIR /actions-runner

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define entrypoint to dynamically configure and run the GitHub Actions runner
ENTRYPOINT ["/entrypoint.sh"]