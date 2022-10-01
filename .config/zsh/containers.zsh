#!/usr/bin/env zsh

# Change settings based on the container.

source "${ZDOTDIR}/utils.zsh"

if [[ -n ${TOOLBOX_PATH} ]]; then # We are inside a toolbox container.
  alias n="nice -20 nvim --listen $NVIMREMOTE"
  TOOLBOX_NAME=$(awk '/name=/{print $2}' FS='"' /run/.containerenv)
  PS1="%n%F{white}@%{$reset_color%}${TOOLBOX_NAME}%{$reset_color%} %F{white}%3~% %F{yellow}  %{$reset_color%}"
  enter_venv
fi
