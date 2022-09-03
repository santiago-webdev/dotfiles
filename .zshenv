# Change the xdg user directories
xdg-user-dirs-update --set DESKTOP "$HOME"/.local/Desktop
xdg-user-dirs-update --set DOWNLOAD "$HOME"/.local/Downloads
xdg-user-dirs-update --set TEMPLATES "$HOME"/.local/Templates
xdg-user-dirs-update --set PUBLICSHARE "$HOME"/.local/Public
xdg-user-dirs-update --set DOCUMENTS "$HOME"/.local/Documents
xdg-user-dirs-update --set MUSIC "$HOME"/.local/Music
xdg-user-dirs-update --set PICTURES "$HOME"/.local/Pictures
xdg-user-dirs-update --set VIDEOS "$HOME"/.local/Videos

# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_RUNTIME_DIR=/run/user/$UID
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

# Manpagers
if which bat >/dev/null; then
  export MANPAGER="bash -c 'col -b | bat -l man -p'"
fi
export MANWIDTH=999

export ZDOTDIR=$HOME/.config/zsh # Zsh config
export LIBVA_DRIVER_NAME=iHD # Hardware acceleration
export KDEHOME=${XDG_CONFIG_HOME}/kde # KDE
export LANG=en_US.UTF-8
export LC_COLLATE=C
export SUDO_EDITOR=nvim
export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="firefox-developer-edition" # firefox brave firefox-developer-edition
export MOZ_ENABLE_WAYLAND=1 # Wayland in Firefox
export MOZ_USE_XINPUT2=1 # Pixel-perfect trackpad scrolling
export TERMINAL="konsole" # wezterm kitty konsole
export TERM="xterm-256color" # xterm-kitty xterm-256color
export COLORTERM="truecolor"
export LESSHISTFILE="-"
export KEYTIMEOUT=1
export ZETTELPY_DIR="${HOME}/.zettels"
export CDPATH="${HOME}/workspace" # Add directories to CDPATH
export PATH=/home/$USER/.local/bin:$PATH # Binaries
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden' # fzf
export NVIMREMOTE="${XDG_DATA_HOME}/nvim/nvim.pipe"
# export GTK2_RC_FILES=${XDG_CONFIG_HOME}/gtk-2.0/gtkrc # This isn't going to work because KDE Plasma hardcodes the value

# JS related environment variables
export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npmrc # NPM
export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npmrc;
# export NVM_DIR=${XDG_DATA_HOME}/nvm # NVM

# Golang related environment variables
export GOPATH="${XDG_DATA_HOME}"/go

# Java related environment variables
export SDKMAN_DIR=${HOME}/.local/lib/sdkman # SDKMAN

# Rust related environment variables
export RUSTUP_HOME=${XDG_DATA_HOME}/rustup # Rustup
export CARGO_HOME=${XDG_DATA_HOME:-$HOME/.local/share}/cargo # Cargo install dir
export PATH=$PATH:${XDG_DATA_HOME}/cargo/bin # Add cargo binaries to PATH

# Haskell related environment variables
export PATH=$HOME/.cabal/bin:$PATH # Cabal
export GHCUP_INSTALL_BASE_PREFIX=${XDG_DATA_HOME}/ghcup # Ghcup install dir
export GHCUP_USE_XDG_DIRS="I hope haskell is worth it" # ghcup
export STACK_ROOT="${XDG_DATA_HOME}"/stack
export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_CACHE_HOME"/cabal
