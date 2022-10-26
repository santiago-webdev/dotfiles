#!/usr/bin/env zsh
source "${ZDOTDIR}/utils.zsh"

# Change settings based on the container.

# Actions when changing of directory
function show_context() {
  if [[ -n ${TOOLBOX_PATH} ]]; then # We are inside a toolbox container.
    exa -1ah --icons --colour-scale --group-directories-first -T -L1
  else
    ls -1a
  fi
}

if [[ -n ${TOOLBOX_PATH} ]]; then # We are inside a toolbox container.
  alias n="nice -20 nvim --listen $NVIMREMOTE"

  TOOLBOX_NAME=$(awk '/name=/{print $2}' FS='"' /run/.containerenv)
  PS1="%n%F{green}@%{$reset_color%}${TOOLBOX_NAME}%{$reset_color%} %F{blue}%3~% %F{yellow}  %{$reset_color%}"

  enter_venv
fi
