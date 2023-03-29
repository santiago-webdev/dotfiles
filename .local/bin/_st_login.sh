#!/usr/bin/env bash

# Warm up the container
distrobox enter main

# Remove files created by various programs like `distrobox` and `wget`
rm -rf \
  ~/.bash_history \
  ~/.bashrc \
  ~/.viminfo \
  ~/.wget-hsts
