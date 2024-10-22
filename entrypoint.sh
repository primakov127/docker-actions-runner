#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if RUNNER_VERSION, RUNNER_URL, and RUNNER_TOKEN are set
if [ -z "$RUNNER_VERSION" ]; then
    echo "Error: RUNNER_VERSION is not set."
    exit 1
fi

if [ -z "$RUNNER_URL" ]; then
    echo "Error: RUNNER_URL is not set."
    exit 1
fi

if [ -z "$RUNNER_TOKEN" ]; then
    echo "Error: RUNNER_TOKEN is not set."
    exit 1
fi

# Download the GitHub Actions runner package
echo "Downloading GitHub Actions runner version ${RUNNER_VERSION}..."
curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Extract the GitHub Actions runner
echo "Extracting runner..."
tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Install runner dependencies
echo "Installing dependencies..."
./bin/installdependencies.sh

# Configure the runner
echo "Configuring runner with URL: ${RUNNER_URL}..."
./config.sh --unattended --url ${RUNNER_URL} --token ${RUNNER_TOKEN}

# Run the runner
echo "Starting runner..."
exec ./run.sh
