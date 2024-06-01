# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(fzf --bash)"
eval "$(fnm env --use-on-cd)"
source "$SDKMAN_DIR/bin/sdkman-init.sh"
source "$CARGO_HOME/env"
eval "$(zoxide init bash)"
