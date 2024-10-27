#!/usr/bin/env bash

# Function to set the system performance mode
set_mode() {
  local mode="$1"
  
  case $mode in
    1)
      # Battery Saving mode
      echo "Setting to Battery Saving mode..."
      echo "\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0013B001" | sudo tee /proc/acpi/call
      ;;
    2)
      # Extreme Performance mode
      echo "Setting to Extreme Performance mode..."
      echo "\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0012B001" | sudo tee /proc/acpi/call
      ;;
    3)
      # Intelligent Cooling mode
      echo "Setting to Intelligent Cooling mode..."
      echo "\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001" | sudo tee /proc/acpi/call
      ;;
    *)
      echo "Invalid mode selected. Exiting."
      exit 1
      ;;
  esac
}

# Verify the current setting
verify_mode() {
  echo "\_SB.PCI0.LPC0.EC0.PFMM" | sudo tee /proc/acpi/call
  sudo cat /proc/acpi/call
}

# Menu to choose the performance mode
echo "Select the performance mode:"
echo "1) Battery Saving"
echo "2) Extreme Performance"
echo "3) Intelligent Cooling"
read -p "Enter the number of the mode you want to set: " mode

# Set the mode
set_mode $mode

# Verify the setting
echo "Verifying the current mode..."
verify_mode

exit 0

