#!/usr/bin/env bash

# Function to set brightness
set_brightness() {
    # Get a list of all backlight devices
    for brightness_device in /sys/class/backlight/*/; do
        # Get maximum brightness value
        max_brightness=$(cat "${brightness_device}max_brightness")
        
        # Calculate 10% of max_brightness
        target_brightness=$((max_brightness * 10 / 100))
        
        # Set the new brightness value using brightnessctl (no sudo needed)
        brightnessctl set "${target_brightness}"
    done
}

# Ensure brightnessctl is installed
if ! command -v brightnessctl &> /dev/null; then
    echo "brightnessctl is not installed. Please install it first."
    echo "On Ubuntu/Debian: sudo apt install brightnessctl"
    echo "On Fedora: sudo dnf install brightnessctl"
    echo "On Arch: sudo pacman -S brightnessctl"
    exit 1
fi

# Create user systemd directory if it doesn't exist
mkdir -p ~/.config/systemd/user/

# Create systemd service file
cat << EOF > ~/.config/systemd/user/set-brightness.service
[Unit]
Description=Set screen brightness to 10%
After=suspend.target
After=hibernate.target
After=hybrid-sleep.target

[Service]
Type=oneshot
ExecStart=$(readlink -f "$0")

[Install]
WantedBy=default.target
EOF

# Create systemd resume script
cat << EOF > ~/.config/systemd/user/set-brightness-resume.service
[Unit]
Description=Set screen brightness to 10% after resume
After=suspend.target
After=hibernate.target
After=hybrid-sleep.target

[Service]
Type=simple
ExecStart=$(readlink -f "$0")

[Install]
WantedBy=suspend.target
WantedBy=hibernate.target
WantedBy=hybrid-sleep.target
EOF

# Enable the services at user level
systemctl --user daemon-reload
systemctl --user enable set-brightness.service
systemctl --user enable set-brightness-resume.service
systemctl --user start set-brightness.service

# Set initial brightness
set_brightness

echo "Brightness control has been set up for your user account."
echo "The script will run automatically on boot and resume from sleep."
