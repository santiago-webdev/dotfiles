export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=es_AR.UTF-8
export LC_TIME=es_AR.UTF-8
export LC_MONETARY=es_AR.UTF-8
export LC_PAPER=es_AR.UTF-8
export LC_MEASUREMENT=es_AR.UTF-8
export LC_NAME=es_AR.UTF-8
export LC_ADDRESS=es_AR.UTF-8
export LC_TELEPHONE=es_AR.UTF-8
export LC_IDENTIFICATION=es_AR.UTF-8
export LC_COLLATE=C  # For stable sorting
export LC_ALL=''

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export PATH="$PATH:$XDG_DATA_HOME/flatpak/exports/bin"
export PATH="$PATH:/var/lib/flatpak/exports/bin"
export PATH="$HOME/.local/bin:$PATH"

export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup

export ANSIBLE_HOME=$XDG_CONFIG_HOME/ansible
export ANSIBLE_CONFIG=$XDG_CONFIG_HOME/ansible.cfg
export ANSIBLE_GALAXY_CACHE_DIR=$XDG_CACHE_HOME/ansible/galaxy_cache

export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

export SDKMAN_DIR=$XDG_DATA_HOME/sdkman

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
# export QT_STYLE_OVERRIDE=adwaita # GNOME
export EDITOR=nvim
export VISUAL=nvim

# https://github.com/junegunn/fzf?tab=readme-ov-file#key-bindings-for-command-line
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
. "/home/st/.local/share/cargo/env"
