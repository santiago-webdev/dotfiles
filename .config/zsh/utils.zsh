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

# Git Status
function gitstatus() {
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git svn

  # Setup a hook that runs before every ptompt.
  function precmd_vcs_info() {
    vcs_info
  }
  precmd_functions+=(precmd_vcs_info)

  zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

  function +vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
      git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!' # Signify new files with a bang
    fi
  }

  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}❰%{$fg[red]%}%m%u%c%{$fg[yellow]%} %{$fg[magenta]%}%b%{$fg[blue]%}❱"
}

# Clone plugins repos
function clone-plugins() {
  mkdir -p "${ZDOTDIR}/plugins"
  cd "${ZDOTDIR}/plugins"
  git clone --depth=1 https://github.com/zsh-users/zsh-completions.git
  git clone --depth=1 https://github.com/Aloxaf/fzf-tab
  git clone --depth=1 https://github.com/hlissner/zsh-autopair
  git clone --depth=1 https://github.com/romkatv/zsh-defer
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions
  git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search
  git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting
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

function separator() {
  printf '━%.0s' {1..$COLUMNS}
}
