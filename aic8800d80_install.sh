#!/bin/bash

# AIC8800D80 Driver Installation and Deinstallation Script for Linux Mint Zara
# This script installs or uninstalls the AIC8800D80 WiFi driver with progress bars.
# Run as root or with sudo. Tested on Ubuntu-based systems like Linux Mint.

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function for simple progress bar (simulated, as some steps don't support real progress)
progress_bar() {
    local duration=$1
    local width=50
    local elapsed=0
    echo -n "["
    for ((i=0; i<width; i++)); do
        sleep $(echo "scale=2; $duration / $width" | bc)
        printf "█"
        ((elapsed++))
        if [ $elapsed -eq $width ]; then
            echo "] 100%% Complete"
            break
        fi
    done
    echo ""
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    print_error "Please run this script with sudo: sudo $0"
    exit 1
fi

# Interactive menu for installation or deinstallation
echo -e "${YELLOW}=== AIC8800D80 WiFi Driver Installer/Uninstaller for Linux Mint Zara ===${NC}"
echo "This script manages the AIC8800D80 driver from https://github.com/shenmintao/aic8800d80"
echo "Supported devices: Tenda U11, AX913B (WiFi only, no Bluetooth)."
echo ""
echo "Choose an option:"
echo "  1) Install the driver"
echo "  2) Uninstall the driver"
echo "  3) Exit"
read -p "Enter your choice (1, 2, or 3): " choice
echo ""

# Deinstallation routine
uninstall_driver() {
    print_status "Starting deinstallation..."

    # Step 1: Unload the driver module
    print_status "Step 1: Unloading driver module..."
    echo -n "Removing aic8800_fdrv module... "
    if lsmod | grep -q aic8800_fdrv; then
        modprobe -r aic8800_fdrv > /dev/null 2>&1
        progress_bar 2
        if lsmod | grep -q aic8800_fdrv; then
            print_error "Failed to unload module. Check if it's in use (dmesg)."
            exit 1
        else
            print_status "Module unloaded."
        fi
    else
        print_warning "Module aic8800_fdrv not loaded."
        progress_bar 1
    fi

    # Step 2: Remove firmware files
    print_status "Step 2: Removing firmware files..."
    echo -n "Deleting /lib/firmware/aic8800*... "
    rm -rf /lib/firmware/aic8800* > /dev/null 2>&1
    progress_bar 2
    print_status "Firmware files removed."

    # Step 3: Remove udev rules
    print_status "Step 3: Removing udev rules..."
    echo -n "Deleting aic.rules... "
    rm -f /lib/udev/rules.d/aic.rules > /dev/null 2>&1
    progress_bar 1
    print_status "Udev rules removed."

    # Step 4: Remove driver files
    print_status "Step 4: Removing driver files..."
    echo -n "Cleaning up driver files... "
    rm -f /lib/modules/$(uname -r)/kernel/drivers/net/wireless/aic8800_fdrv.ko > /dev/null 2>&1
    depmod -a > /dev/null 2>&1
    progress_bar 2
    print_status "Driver files removed."

    # Step 5: Clean up cloned repository
    print_status "Step 5: Cleaning up temporary files..."
    echo -n "Removing /tmp/aic8800d80... "
    rm -rf /tmp/aic8800d80 > /dev/null 2>&1
    progress_bar 1
    print_status "Temporary files removed."

    print_status "Deinstallation complete! Reboot recommended to ensure cleanup."
    echo -e "${GREEN}=== Deinstallation Finished ===${NC}"
    exit 0
}

# Installation routine
install_driver() {
    # Step 1: Check and install prerequisites
    print_status "Step 1: Installing prerequisites..."
    echo -n "Updating package list... "
    apt update > /dev/null 2>&1
    progress_bar 2
    echo -n "Installing git, build-essential, bc, and kernel headers... "
    apt install -y git build-essential bc linux-headers-$(uname -r) > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        print_error "Failed to install prerequisites. Check your package manager."
        exit 1
    fi
    progress_bar 10
    print_status "Prerequisites installed."

    # Step 2: Clone the repository
    print_status "Step 2: Cloning repository..."
    cd /tmp
    if [ -d "aic8800d80" ]; then
        rm -rf aic8800d80
    fi
    echo -n "Cloning from GitHub... "
    git clone https://github.com/shenmintao/aic8800d80.git > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        print_error "Failed to clone repository. Check internet connection."
        exit 1
    fi
    progress_bar 5
    cd aic8800d80
    print_status "Repository cloned."

    # Step 3: Clean up old firmware
    print_status "Step 3: Cleaning up old firmware..."
    echo -n "Removing old aic8800 folders from /lib/firmware... "
    rm -rf /lib/firmware/aic8800* > /dev/null 2>&1
    progress_bar 1
    print_status "Old firmware cleaned."

    # Step 4: Copy udev rules
    print_status "Step 4: Installing udev rules..."
    echo -n "Copying aic.rules... "
    cp aic.rules /lib/udev/rules.d/ > /dev/null 2>&1
    progress_bar 1
    print_status "Udev rules installed."

    # Step 5: Copy firmware
    print_status "Step 5: Installing firmware..."
    echo -n "Copying firmware files... "
    cp -r ./fw/aic8800D80 /lib/firmware/ > /dev/null 2>&1
    progress_bar 2
    print_status "Firmware installed."

    # Step 6: Compile and install driver
    print_status "Step 6: Compiling driver..."
    cd drivers/aic8800
    echo -n "Running make clean... "
    make clean > /dev/null 2>&1
    progress_bar 2
    echo -n "Running make... "
    make > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        print_error "Compilation failed! Check kernel compatibility."
        exit 1
    fi
    progress_bar 15
    echo -n "Running make install... "
    make install > /dev/null 2>&1
    progress_bar 5
    print_status "Driver installed."

    # Step 7: Load the module
    print_status "Step 7: Loading driver module..."
    echo -n "Loading aic8800_fdrv... "
    modprobe aic8800_fdrv > /dev/null 2>&1
    progress_bar 2
    if lsmod | grep -q aic8800_fdrv; then
        print_status "Module loaded successfully."
    else
        print_warning "Module may not have loaded. Check dmesg for errors."
    fi

    # Step 8: Verification
    print_status "Step 8: Verifying installation..."
    echo "Checking loaded modules:"
    lsmod | grep aic
    echo ""
    echo "Checking WiFi interfaces (plug in your device if needed):"
    iwconfig
    echo ""
    print_status "Installation complete! Reboot recommended. Plug in your WiFi adapter and check 'iwconfig' or Network Manager."

    # Cleanup
    cd /
    rm -rf /tmp/aic8800d80

    echo -e "${GREEN}=== Installation Finished ===${NC}"
}

# Process user choice
case $choice in
    1)
        install_driver
        ;;
    2)
        uninstall_driver
        ;;
    3)
        print_warning "Exiting without changes."
        exit 0
        ;;
    *)
        print_error "Invalid choice. Please select 1, 2, or 3."
        exit 1
        ;;
esac
