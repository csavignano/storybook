# Getting Started

This project uses DDEV for a consistent and easy-to-use local development environment and NVM to manage Node.js versions.

For this training, we’ve provided **two ways** to get your Drupal site running:

1. **On your own computer** (recommended) — using DDEV and NVM.
2. **In your browser** — using GitHub Codespaces (no installation required).

We recommend running the project on your **own computer** so you can continue using it after training.

---
## On your own computer

## 1. Install DDEV

DDEV provides a quick way to set up a local Drupal environment.
1. Follow the official installation guide:
Go to the [DDEV Get Started page](https://ddev.com/get-started/) and follow the instructions for your operating system (macOS, Windows, or Linux).

#### For Windows Users

For an excellent step-by-step video walk-through, you can watch this guide on setting up DDEV with Windows WSL2: [Watch: DDEV Local from scratch with Windows WSL2](https://ddev.com/blog/watch-ddev-local-from-scratch-with-windows-wsl2/)

2. Verify your installation by running this command in your terminal:

   ```bash
   ddev version
If you see a version number, you’re good to go! 🎉

### 2. Install NVM (Node Version Manager)

We use NVM to manage the different Node.js versions required for frontend tooling.

**Note:** You can run NVM within the DDEV container, but for a faster experience, we recommend installing it directly on your host machine.

You can find excellent installation guides here:

* [NVM Explained - Better Stack](https://betterstack.com/community/guides/scaling-nodejs/nvm-explained/)
* [Node Version Manager (NVM) Install Guide - freeCodeCamp](https://www.freecodecamp.org/news/node-version-manager-nvm-install-guide/)
---

# In your browser

This GitHub Codespace gives you a complete DDEV development environment for your Drupal 11 project. It even handles automated data import for you!

### Before You Begin

1.  **Fork this Repository:**
    Before you start, please fork this repository to your own GitHub account:
    👉 [https://github.com/chazchumley/storybook](https://github.com/chazchumley/storybook)

### Quick Start

1.  **Open the Codespace**:
    On your forked repository page, click the green **`<> Code`** button. From the dropdown menu, click **Create codespace on main**.
2.  **Wait for the Magic**: The devcontainer will automatically set everything up for you, including installing DDEV and verifying your project structure. **This process may take 10-15 minutes the first time you run it, so please be patient.** You'll be ready to start coding in no time!
3. **Start the DDEV Project**:
    Once the Codespace has loaded, open the terminal in your browser (it should be at the bottom of the VS Code window) and run the following command to start your project:

    ```bash
    ddev start
4. **Access Your Site**: The site will be available at port 8080 (auto-opens in browser)

## Your Project Structure

```
├── .devcontainer/           # Codespace configuration
├── .ddev/                  # Your existing DDEV configuration
│   └── config.yaml         # Your DDEV settings with hooks
├── config/sync/            # Your existing Drupal config
├── db/                     # Your database backups
│   └── site.sql.gz        # Your database snapshot
├── web/                   # Your existing Drupal docroot
└── README.md
```

## Your DDEV Hooks

Your existing DDEV configuration includes these automated hooks:

### POST-START Hook
Runs automatically when you start DDEV:
```bash
ddev import-db --file=db/site.sql.gz && ddev drush cim -y && ddev drush cr
```

### PRE-STOP Hook
Runs automatically when you stop DDEV:
```bash
ddev drush cr && ddev drush cex -y && ddev drush sql-dump --gzip --result-file=../db/site.sql
```

## Available Services

- **Drupal Site**: Port 8080 (auto-opens in browser)

## Common Commands

### DDEV Commands
```bash
# Start the environment
ddev start

# Stop the environment
ddev stop

# Restart the environment
ddev restart

# SSH into the web container
ddev ssh

# View project information
ddev describe

# View logs
ddev logs
```

### Drupal/Drush Commands
```bash
# Generate one-time login link
ddev drush uli

# Clear cache
ddev drush cache:rebuild

# Run database updates
ddev drush updatedb

# Export configuration
ddev drush config:export

# Import configuration
ddev drush config:import

# Check site status
ddev drush status
```

### Database Commands
```bash
# Your hooks handle these automatically, but manual commands:
ddev import-db --file=db/site.sql.gz    # Import database
ddev drush sql-dump --gzip --result-file=../db/site.sql  # Backup database
ddev drush sql-cli                       # Access database CLI
```

### Configuration Commands
```bash
# Your hooks handle these automatically, but manual commands:
ddev drush cim -y          # Import configuration
ddev drush cex -y          # Export configuration
ddev drush config:status   # Check config status
```

## File Permissions

The import script automatically handles file permissions, but if you need to fix them manually:

```bash
ddev exec "chown -R www-data:www-data /var/www/html/web/sites/default/files"
ddev exec "chmod -R 755 /var/www/html/web/sites/default/files"
```

## Troubleshooting

### DDEV Won't Start
```bash
# Check Docker status
sudo service docker status

# Start Docker if needed
sudo service docker start

# Try starting DDEV again
ddev start
```

### Database Import Issues
```bash
# Check available snapshots
ls -la database-snapshots/

# Import with verbose output
ddev import-db --src=database-snapshots/your-file.sql --verbose
```

### Config Import Issues
```bash
# Check config files
ls -la config/sync/

# Import with verbose output
ddev drush config:import --verbose
```

## Development Workflow

Your DDEV hooks automate the common development workflow:

### Starting Work
1. **Start DDEV**: `ddev start`
   - Automatically imports latest database from `db/site.sql.gz`
   - Automatically imports configuration from `config/sync/`
   - Automatically clears cache
2. **Get Login Link**: `ddev drush uli`
3. **Start Development**: Make your changes

### Ending Work
1. **Stop DDEV**: `ddev stop`
   - Automatically clears cache
   - Automatically exports configuration to `config/sync/`
   - Automatically creates fresh database backup at `db/site.sql`
2. **Commit Changes**: Add your changes to Git

This ensures your database and configuration are always in sync!

## Performance Tips

- The environment uses Mutagen for file sync performance
- Large file uploads should be placed directly in the `files/` directory
- Use `ddev logs` to monitor performance issues

## Extensions and Tools

The Codespace includes these VS Code extensions:
- PHP Intelephense (PHP language support)
- Prettier (code formatting)
- Tailwind CSS IntelliSense
- Auto Rename Tag
- Apache syntax highlighting

## Security Notes

- This environment is for development only
- The database credentials are default DDEV values (db/db/db)
- SSL certificates are self-signed development certificates
- Never use this configuration in production
