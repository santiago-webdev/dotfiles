# Change the XDG user directories
if [[ -f "/usr/bin/xdg-user-dirs-update" ]]; then
  xdg-user-dirs-update --set DESKTOP "${HOME}/.local/Desktop" &>/dev/null
  xdg-user-dirs-update --set DOWNLOAD "${HOME}/.local/Downloads" &>/dev/null
  xdg-user-dirs-update --set TEMPLATES "${HOME}/.local/Templates" &>/dev/null
  xdg-user-dirs-update --set PUBLICSHARE "${HOME}/.local/Public" &>/dev/null
  xdg-user-dirs-update --set DOCUMENTS "${HOME}/.local/Documents" &>/dev/null
  xdg-user-dirs-update --set MUSIC "${HOME}/.local/Music" &>/dev/null
  xdg-user-dirs-update --set PICTURES "${HOME}/.local/Pictures" &>/dev/null
  xdg-user-dirs-update --set VIDEOS "${HOME}/.local/Videos" &>/dev/null
fi

# XDG paths
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_RUNTIME_DIR="/run/user/${UID}"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_DESKTOP_DIR="${HOME}/.local/Desktop"
export XDG_DOWNLOAD_DIR="${HOME}/.local/Downloads"
export XDG_TEMPLATES_DIR="${HOME}/.local/Templates"
export XDG_PUBLICSHARE_DIR="${HOME}/.local/Public"
export XDG_DOCUMENTS_DIR="${HOME}/.local/Documents"
export XDG_MUSIC_DIR="${HOME}/.local/Music"
export XDG_PICTURES_DIR="${HOME}/.local/Pictures"
export XDG_VIDEOS_DIR="${HOME}/.local/Videos"

# # Manpagers
# if which bat >/dev/null
# then
#   export MANPAGER="bash -c 'col -b | bat -l man -p'"
# fi
# export MANWIDTH=999

export ZDOTDIR="${HOME}/.config/zsh" # Zsh config
# export FPATH="${ZDOTDIR}/completion:${FPATH}" # Completion sources

export LIBVA_DRIVER_NAME=iHD # Hardware acceleration
export SUDO_EDITOR="nvim"
export EDITOR="nvim"
export BROWSER="firefox" # firefox brave firefox-developer-edition
export MOZ_ENABLE_WAYLAND=1 # Wayland in Firefox
export MOZ_USE_XINPUT2=1 # Pixel-perfect trackpad scrolling
export TERMINAL="konsole" # wezterm kitty konsole foot
export TERM="xterm-256color" # This is going to be xterm-kitty when running kitty.
export COLORTERM="truecolor"
export LESSHISTFILE="-"
export KEYTIMEOUT=1
export ZETTELPY_DIR="${HOME}/.zettels"
# export CDPATH="${HOME}/workspace" # Add directories to CDPATH
export PATH="${HOME}/.local/bin:${PATH}" # Binaries
export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden" # fzf

# Flatpak related environment variables
# export PATH="${PATH}:/var/lib/flatpak/exports/bin"
export PATH="${PATH}:$XDG_DATA_HOME/flatpak/exports/bin"

# JS related environment variables
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc" # NPM
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NVM_DIR="${HOME}/.config/nvm"

# Golang related environment variables
export GOPATH="${XDG_DATA_HOME}/go"

# Java related environment variables
export SDKMAN_DIR="${HOME}/.local/lib/sdkman" # SDKMAN

# Rust related environment variables
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup" # Rustup
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo" # Cargo install dir
export CARGO_INSTALL_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/cargo" # Cargo install dir
export PATH="${PATH}:${XDG_DATA_HOME}/cargo/bin" # Add cargo binaries to PATH

# # Haskell related environment variables
# export PATH="${HOME}/.cabal/bin:${PATH}" # Cabal
# export GHCUP_INSTALL_BASE_PREFIX="${XDG_DATA_HOME}/ghcup" # Ghcup install dir
# export GHCUP_USE_XDG_DIRS="I hope haskell is worth it" # ghcup
# export STACK_ROOT="${XDG_DATA_HOME}/stack"
# export CABAL_CONFIG="${XDG_CONFIG_HOME}/cabal/config"
# export CABAL_DIR="${XDG_CACHE_HOME}/cabal"
