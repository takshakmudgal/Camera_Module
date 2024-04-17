#!/bin/bash

# Test Fedora version
if [ !  $(command -v dnf) ]; then
  echo "This script appears to be for Fedora-based systems, but 'dnf' is not found."
  echo "Exiting..."
  exit
fi

# Update package list and upgrade
sudo dnf update -y

# Install tools needed for kernel module compilation
sudo dnf install kernel-devel dkms -y

# Get kernel source (Fedora way)
dnf dnf-automatic && dnf builddep kernel-headers -y

# Change directory (assuming you want it in your home)
cd ~

# Download updated driver (replace URL with your actual driver source)
wget https://raw.githubusercontent.com/takshakmudgal/Camera_Module/main/uvc_driver.c

# Compile and install (Fedora specific commands)
dkms autoinstall  # This will build and install the module

# Reload modules (similar to rmmod and modprobe)
sudo dnf module reload

# Reboot (optional, uncomment if needed)
reboot