# Minimal PHP 8.2 base image for DDEV
FROM mcr.microsoft.com/devcontainers/php:8.2-bullseye

# Install DDEV dependencies
RUN apt-get update && apt-get install -y \
    libnss3-tools \
    libxss1 \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
