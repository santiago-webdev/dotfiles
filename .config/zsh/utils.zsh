#!/usr/bin/env zsh

function enter_venv() {
  if [[ -z "${VIRTUAL_ENV}" ]]; then
    if [[ -d ./.venv ]] ; then
      source ./.venv/bin/activate
    fi
  else
    parentdir="$(dirname "$VIRTUAL_ENV")"
    if [[ "$PWD"/ != "$parentdir"/* ]] ; then
      deactivate
    fi
  fi
}

# Exit error code of the last command
function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg[red]%}❰%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}❱%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  fi
}

function setup-completion() {
  mkdir "${ZDOTDIR}/completion" # Create directory to store completion

  # Podman
  podman completion zsh -f ${ZDOTDIR}/completion/_podman

  # Completion for rustup and cargo
  rustup completions zsh rustup > ${ZDOTDIR}/completion/_rustup
  rustup completions zsh cargo > ${ZDOTDIR}/completion/_cargo

  rm -rf ${ZDOTDIR}/.zcompdump
  rm -rf ${ZDOTDIR}/.zcompdump.zwc
  exec zsh -l
}

# Extracting files
function ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1;;
      *.tar.gz)   tar xzf $1;;
      *.tar.xz)   tar xJf $1;;
      *.bz2)      bunzip2 $1;;
      *.rar)      unrar x $1;;
      *.gz)       gunzip $1;;
      *.tar)      tar xf $1;;
      *.tbz2)     tar xjf $1;;
      *.tgz)      tar xzf $1;;
      *.zip)      unzip $1 -d $(basename $1 .zip);;
      *.Z)        uncompress $1;;
      *.7z)       7z x $1 ;;
      *)          echo "'$1' cannot be extracted via ex";;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
