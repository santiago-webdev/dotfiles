#!/usr/bin/env bash

set -e

# RUST_TOOLS:
if ! command -v rustup &> /dev/null
then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi


# FNM:
if ! command -v fnm &> /dev/null
then
  cargo install fnm

  export PATH="/home/st/.local/share/fnm:$PATH"
  eval "$(fnm env)"
  fnm install --lts
fi


# YARN:
if ! command -v yarn &> /dev/null
then
  corepack enable
  corepack prepare yarn@stable --activate
fi


glob_npm() {
  npm install --global "$@"
}

glob_npm \
  live-server \
  prettier

# Lua
sudo zypper install -y lua-language-server
cargo install stylua

# Typescript
glob_npm \
  typescript \
  typescript-language-server

# html, css and json
glob_npm vscode-langservers-extracted

# yaml
glob_npm yaml-language-server

# Svelte
glob_npm svelte-language-server
