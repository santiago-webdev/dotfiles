# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

## EVERYTHING ABOVE THIS IT'S THE VANILLAOS DEFAULTS

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

# https://github.com/junegunn/fzf?tab=readme-ov-file#key-bindings-for-command-line
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
