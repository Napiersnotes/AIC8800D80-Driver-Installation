AIC8800D80 WiFi Driver Installation Script
This script automates the installation and uninstallation of the AIC8800D80 WiFi driver for Linux Mint Zara (and other Ubuntu-based systems). The driver is sourced from shenmintao/aic8800d80 and supports devices like the Tenda U11 and AX913B (WiFi only, no Bluetooth support).
The script features an interactive menu, color-coded output, and simulated progress bars for a user-friendly experience. It includes both installation and deinstallation routines.
Features
Interactive Menu: Choose to install, uninstall, or exit.
Installation: Installs prerequisites, clones the driver repository, compiles the driver, and loads the module.
Deinstallation: Removes the driver module, firmware, udev rules, and temporary files.
Progress Bars: Visual feedback during each step.
Error Handling: Checks for common issues and provides troubleshooting tips.
Prerequisites
Operating System: Linux Mint Zara (or other Ubuntu-based distributions).
Root Privileges: Run the script with sudo.
Internet Connection: Required to clone the repository and install dependencies.
Packages: The script installs the following if not already present:
git
build-essential
bc
linux-headers-$(uname -r) (matching the current kernel)
Hardware: A compatible WiFi adapter (e.g., Tenda U11, AX913B).
Installation
Download the Script:
Save the script as aic8800d80_install.sh.
Make it Executable:
chmod +x aic8800d80_install.sh
Run the Script:
sudo ./aic8800d80_install.sh
Follow the Menu:
Select 1 to install the driver.
Select 2 to uninstall the driver.
Select 3 to exit without changes.
Reboot:
After installation or uninstallation, reboot your system to ensure changes take effect.
Usage
Installation:
Installs dependencies (git, build-essential, bc, kernel headers).
Clones the driver repository from GitHub.
Cleans up old firmware to prevent conflicts.
Copies udev rules and firmware files.
Compiles and installs the driver module (aic8800_fdrv).
Loads the module and verifies the installation with lsmod and iwconfig.
Deinstallation:
Unloads the aic8800_fdrv module.
Removes firmware files, udev rules, and driver files.
Cleans up temporary files from /tmp/aic8800d80.
Verification:
After installation, check lsmod | grep aic to confirm the module is loaded.
Use iwconfig to verify the WiFi adapter is detected (plug in the device if needed).
Troubleshooting
Compilation Errors:
Ensure linux-headers-$(uname -r) matches the running kernel (uname -r).
Run dmesg to check for kernel-related errors.
Module Not Loading:
Verify the WiFi adapter is plugged in.
Check dmesg for module loading errors.
No WiFi Interface:
Ensure the device is supported (e.g., Tenda U11, AX913B).
Reboot after installation and check iwconfig.
Kernel Updates:
If the kernel is updated, re-run the installation to recompile the driver for the new kernel.
Notes
Reboot Recommended: Always reboot after installing or uninstalling to ensure system stability.
Kernel Compatibility: The driver is compiled for the current kernel. Kernel updates may require reinstallation.
Bluetooth: This driver does not support Bluetooth functionality for the AIC8800D80 chipset.
Repository: The script clones the driver from shenmintao/aic8800d80.
License
This script is provided under the MIT License. The AIC8800D80 driver repository may have its own licensing terms; refer to shenmintao/aic8800d80 for details.
Acknowledgments
Thanks to shenmintao for maintaining the AIC8800D80 driver repository.
Built for Linux Mint Zara but compatible with other Ubuntu-based systems.
