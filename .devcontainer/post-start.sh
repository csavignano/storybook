#!/bin/bash
set -e

# Navigate to the workspace (your existing project)
cd /workspaces/$(basename "$GITHUB_REPOSITORY")

# Start Docker service if not running
if ! docker info > /dev/null 2>&1; then
    echo "🐳 Starting Docker service..."
    sudo service docker start
    sleep 5
fi

# Check if DDEV is already running
if ! ddev status | grep -q "running"; then
    echo "🚀 Starting DDEV environment..."
    echo "Your post-start hooks will automatically:"
    echo "  - Import database from db/site.sql.gz"
    echo "  - Import configuration with 'drush cim -y'"
    echo "  - Clear cache with 'drush cr'"
    echo ""
    ddev start
else
    echo "✅ DDEV is already running"
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
echo "- ddev ssh             # SSH into the web container"
echo "- ddev composer        # Run Composer commands"
echo "- ddev drush           # Run Drush commands"
echo "- ddev logs            # View container logs"
echo "- ddev drush uli       # Generate one-time login link"
