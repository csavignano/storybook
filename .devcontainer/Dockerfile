FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install additional tools and DDEV
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    lsb-release \
    ca-certificates \
    gnupg \
    && apt-get clean

# Install DDEV
RUN curl -fsSL https://raw.githubusercontent.com/drud/ddev/master/scripts/install_ddev.sh | bash
