#!/bin/bash
set -e

echo "🚀 Starting DDEV Drupal 11 setup..."

# Install DDEV
echo "📦 Installing DDEV..."
curl -fsSL https://pkg.ddev.com/apt/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ddev.gpg > /dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/ddev.gpg] https://pkg.ddev.com/apt/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list

sudo apt-get update && sudo apt-get install -y ddev

# Start Docker service
echo "🐳 Starting Docker service..."
sudo service docker start

# Make sure codespace user can use Docker
sudo usermod -aG docker codespace

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
