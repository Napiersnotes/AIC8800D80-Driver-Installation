# AIC8800D80 WiFi Driver Installation Script

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Linux Mint](https://img.shields.io/badge/Linux%20Mint-Zara-green.svg)](https://www.linuxmint.com/)
[![Download Script](https://img.shields.io/badge/Download-Script-brightgreen)](https://github.com/<your-username>/<your-repo-name>/raw/main/aic8800d80_install.sh)

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
   ```
2. **Make the Script Executable**:
   ```bash
   chmod +x aic8800d80_install.sh
   ```
3. **Run the Script**:
   ```bash
   sudo ./aic8800d80_install.sh
   ```
4. **Follow the Menu**:
   - Select `1` to install the driver.
   - Select `2` to uninstall the driver.
   - Select `3` to exit without changes.
5. **Reboot**:
   - After installation or uninstallation, reboot your system to ensure changes take effect.

## Usage
### Installation
- Installs dependencies (`git`, `build-essential`, `bc`, kernel headers).
- Clones the driver repository from [shenmintao/aic8800d80](https://github.com/shenmintao/aic8800d80).
- Cleans up old firmware to prevent conflicts.
- Copies udev rules and firmware files to appropriate system directories.
- Compiles and installs the `aic8800_fdrv` driver module.
- Loads the module and verifies the installation with `lsmod` and `iwconfig`.

### Deinstallation
- Unloads the `aic8800_fdrv` module.
- Removes firmware files, udev rules, and driver files.
- Cleans up temporary files from `/tmp/aic8800d80`.

### Verification
- After installation, check the loaded module:
  ```bash
  lsmod | grep aic
  ```
- Verify the WiFi interface (plug in the device if needed):
  ```bash
  iwconfig
  ```

## Troubleshooting
- **Compilation Errors**:
  - Ensure `linux-headers-$(uname -r)` matches the running kernel (`uname -r`).
  - Run `dmesg` to check for kernel-related errors.
- **Module Not Loading**:
  - Verify the WiFi adapter is plugged in.
  - Check `dmesg` for module loading errors.
- **No WiFi Interface**:
  - Confirm the device is supported (e.g., Tenda U11, AX913B).
  - Reboot after installation and check `iwconfig`.
- **Kernel Updates**:
  - If the kernel is updated, re-run the installation to recompile the driver for the new kernel.

## Notes
- **Reboot Recommended**: Always reboot after installing or uninstalling to ensure system stability.
- **Kernel Compatibility**: The driver is compiled for the current kernel. Kernel updates may require reinstallation.
- **Bluetooth**: This driver does not support Bluetooth functionality for the AIC8800D80 chipset.
- **Driver Source**: The script uses the driver from [shenmintao/aic8800d80](https://github.com/shenmintao/aic8800d80).

## License
This script is licensed under the [MIT License](LICENSE). The AIC8800D80 driver repository may have its own licensing terms; refer to [shenmintao/aic8800d80](https://github.com/shenmintao/aic8800d80) for details.

## Acknowledgments
- Thanks to [shenmintao](https://github.com/shenmintao) for maintaining the AIC8800D80 driver repository.
- Designed for Linux Mint Zara but compatible with other Ubuntu-based systems.

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for suggestions, bug reports, or improvements.

## Contact
For questions or support, open an issue on this repository or contact the maintainer.
