#!/usr/bin/env bash

# Warm up the container
distrobox enter main

# Remove files created by various programs like `distrobox` and `wget`
rm -rf \
  ~/.bash_history \
  ~/.bashrc \
  ~/.profile \
  ~/.wget-hsts

# Update flatpak for the simple reason that I don't want to worry about it.
flatpak upgrade -y

# # Start firefox
# firefox
