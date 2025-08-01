#!/bin/bash
set -e

# Navigate to the workspace
cd /workspaces/$(basename "$GITHUB_REPOSITORY")

# Function to wait for Docker
wait_for_docker() {
    echo "🐳 Starting Docker service..."
    sudo service docker start
    # Wait for Docker to be available
    while ! docker info > /dev/null 2>&1; do
        echo "⏳ Waiting for Docker..."
        sleep 2
    done
    echo "✅ Docker is ready"
}

# Function to wait for DDEV
wait_for_ddev() {
    echo "🚀 Starting DDEV environment..."
    ddev start
    # Wait for DDEV to be fully ready
    while ! ddev describe >/dev/null 2>&1; do
        echo "⏳ Waiting for DDEV..."
        sleep 2
    done
    echo "✅ DDEV is ready"
}

# Main execution
if ! docker info > /dev/null 2>&1; then
    wait_for_docker
fi

if ! ddev status | grep -q "running"; then
    wait_for_ddev
fi

# Display useful information
echo ""
echo "🎉 Development environment is ready!"
echo ""
echo "Your DDEV hooks are configured to:"
echo "📥 POST-START: Import DB → Import Config → Clear Cache"
echo "💾 PRE-STOP: Clear Cache → Export Config → Backup Database"
echo ""
echo "Useful commands:"
echo "- ddev describe        # Show project info and URLs"
echo "- ddev ssh            # SSH into the web container"
echo "- ddev composer       # Run Composer commands"
echo "- ddev drush         # Run Drush commands"
echo "- ddev logs          # View container logs"
echo "- ddev drush uli     # Generate one-time login link"
