# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" &>/dev/null
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}" &>/dev/null
    done
  fi
fi

eval "$(fzf --bash)"
eval "$(fnm env --use-on-cd)"
eval "$(zoxide init bash)"

source "$SDKMAN_DIR/bin/sdkman-init.sh"
source "$CARGO_HOME/env"
. "/home/st/.local/share/cargo/env"
