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

---
### 📚 Storybook

Storybook is used for developing and testing UI components in isolation. To get started, follow these steps in your terminal.

1.  **Navigate to your theme directory**:
    You'll need to move into the custom theme folder where the Storybook setup resides.

    ```bash
    cd web/themes/custom/surface
    ```

2.  **Install Node.js version**:
    Run `nvm install` to ensure you are using the correct Node.js version for the project.

    ```bash
    nvm install
    ```

3.  **Install Node packages**:
    Next, install all the required npm packages.

    ```bash
    npm install
    ```

4.  **Start Storybook**:
    Finally, run the `watch` command to start Storybook and begin watching for changes to your components.

    ```bash
    npm run watch
    ```

After running this command, Storybook should be available at a URL provided in the terminal output.
