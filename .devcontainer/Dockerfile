FROM ghcr.io/ddev/ddev-ssh-agent:latest

# Install additional tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    lsb-release \
    && apt-get clean
