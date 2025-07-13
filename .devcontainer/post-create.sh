#!/bin/bash
set -e

echo "🚀 Starting DDEV Drupal 11 setup..."

# Install required packages
echo "📦 Installing required packages..."
sudo apt-get update
sudo apt-get install -y curl wget gnupg2 software-properties-common apt-transport-https ca-certificates

# Install Composer (since we removed it from PHP feature to save space)
echo "🎼 Installing Composer..."
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

# Install DDEV
echo "📦 Installing DDEV..."
curl -fsSL https://pkg.ddev.com/apt/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ddev.gpg > /dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/ddev.gpg] https://pkg.ddev.com/apt/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list

sudo apt-get update && sudo apt-get install -y ddev

# Start Docker service
echo "🐳 Starting Docker service..."
# Check if Docker is already running
if ! docker info >/dev/null 2>&1; then
    # Try systemctl first (preferred method)
    if sudo systemctl start docker 2>/dev/null; then
        echo "✅ Docker started with systemctl"
    else
        # Fallback to service command if systemctl fails
        if sudo service docker start 2>/dev/null; then
            echo "✅ Docker started with service command"
        else
            echo "⚠️ Docker may already be running or failed to start"
        fi
    fi
else
    echo "✅ Docker is already running"
fi

# Make sure vscode user can use Docker
sudo usermod -aG docker vscode

# Refresh group membership for current session
newgrp docker

# Wait a moment for Docker to be fully ready
sleep 5

# Verify Docker is working
echo "🔍 Verifying Docker installation..."
if docker info >/dev/null 2>&1; then
    echo "✅ Docker is working correctly"
else
    echo "❌ Docker is not responding - you may need to restart the container"
    # Don't exit here, let the rest of the setup continue
fi

# Navigate to the workspace (your existing project)
cd /workspaces/$(basename "$GITHUB_REPOSITORY")

# Verify existing structure
echo "📋 Checking project structure..."
if [ -d ".ddev" ]; then
    echo "✅ Found existing .ddev configuration"
else
    echo "❌ No .ddev directory found"
    exit 1
fi

if [ -d "web" ]; then
    echo "✅ Found existing web directory"
else
    echo "❌ No web directory found"
    exit 1
fi

if [ -d "config/sync" ]; then
    echo "✅ Found existing config/sync directory"
else
    echo "❌ No config/sync directory found"
    exit 1
fi

if [ -f "db/site.sql.gz" ]; then
    echo "✅ Found database backup at db/site.sql.gz"
else
    echo "❌ No database backup found at db/site.sql.gz"
    exit 1
fi

echo "✅ DDEV setup complete!"
echo "🔧 Your existing project structure is ready"
echo "Next step: Run 'ddev start' to start the environment"
echo "Your DDEV hooks will automatically:"
echo "  - Import the database from db/site.sql.gz"
echo "  - Import configuration from config/sync"
echo "  - Clear cache"
