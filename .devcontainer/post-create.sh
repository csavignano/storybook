#!/bin/bash
set -e

# Install DDEV
curl -fsSL https://raw.githubusercontent.com/drud/ddev/master/scripts/install_ddev.sh | bash

# Set up DDEV global config
mkdir -p /home/vscode/.ddev
cp .devcontainer/ddev-global-config/global_config.yaml /home/vscode/.ddev/
chown -R vscode:vscode /home/vscode/.ddev

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

# Verify installations
echo "✅ DDEV version: $(ddev --version)"
echo "✅ Composer version: $(composer --version)"

# Initialize DDEV configuration if needed
if [ ! -f ".ddev/config.yaml" ]; then
    ddev config --project-type=drupal11 --docroot=web --create-docroot
fi
