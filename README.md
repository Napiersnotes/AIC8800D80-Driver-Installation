# AIC8800D80 WiFi Driver Installation Script

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Linux Mint](https://img.shields.io/badge/Linux%20Mint-Zara-green.svg)](https://www.linuxmint.com/)

This script automates the **installation** and **uninstallation** of the AIC8800D80 WiFi driver for **Linux Mint Zara** (and other Ubuntu-based distributions). The driver is sourced from [shenmintao/aic8800d80](https://github.com/shenmintao/aic8800d80) and supports WiFi adapters like the **Tenda U11** and **AX913B** (WiFi only, no Bluetooth support).

The script features an interactive menu, color-coded terminal output, and simulated progress bars for a user-friendly experience. It includes both installation and deinstallation routines, making it easy to manage the driver.

## Features
- **Interactive Menu**: Choose to install, uninstall, or exit.
- **Installation**: Installs dependencies, clones the driver repository, compiles the driver, and loads the module.
- **Deinstallation**: Removes the driver module, firmware, udev rules, and temporary files.
- **Progress Bars**: Visual feedback for each step.
- **Error Handling**: Checks for common issues and provides troubleshooting tips.

## Prerequisites
- **Operating System**: Linux Mint Zara (or other Ubuntu-based distributions).
- **Root Privileges**: Run the script with `sudo`.
- **Internet Connection**: Required to clone the repository and install dependencies.
- **Packages**:
  - `git`
  - `build-essential`
  - `bc`
  - `linux-headers-$(uname -r)` (matching the current kernel)
- **Hardware**: A compatible WiFi adapter (e.g., Tenda U11, AX913B).

## Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/<your-username>/<your-repo-name>.git
   cd <your-repo-name>
