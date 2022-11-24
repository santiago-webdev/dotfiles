{
    # Compile zcompdump, if modified, to increase startup speed.
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zcompile "$zcompdump"
    fi
} &!

typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH # Automatically remove duplicates from these arrays

if [[ $(which plug) ]] then
  plug "zdharma-continuum/fast-syntax-highlighting"

  plug "zap-zsh/vim"

  plug "zsh-users/zsh-history-substring-search"
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down

  plug "zsh-users/zsh-autosuggestions"
  bindkey -M vicmd '^[a' autosuggest-accept
  bindkey -M viins '^[a' autosuggest-execute

  plug "hlissner/zsh-autopair"

  zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'bat --color=always --italic-text=always $realpath'
  zstyle ':fzf-tab:complete:cp:*' fzf-preview 'bat --color=always --italic-text=always $realpath'
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1a --colour-scale --icons --group-directories-first --color=always $realpath'
  function check_terminal_size() {
    if [[ "$LINES $COLUMNS" != "$previous_lines $previous_columns" ]]; then
      set_default_opts
    fi
    previous_lines=$LINES
    previous_columns=$COLUMNS
  }
  function set_default_opts() {
    HEIGHTVAR=$(($LINES/2))
    WIDTHVAR=$(($COLUMNS/2))
    zstyle ':fzf-tab:*' fzf-pad $HEIGHTVAR
    export FZF_DEFAULT_OPTS="--color=fg:#707a8c,bg:-1,hl:#3e9831,fg+:#cbccc6,bg+:#434c5e,hl+:#af87ff \
      --color=dark \
      --color=info:#ea9d34,prompt:#af87ff,pointer:#cb6283,marker:#cb6283,spinner:#ff87d7 \
      --sort \
      --preview-window=right:$WIDTHVAR \
      --bind '?:toggle-preview' \
      --border rounded"
  }
  set_default_opts && trap 'check_terminal_size' WINCH
  plug "Aloxaf/fzf-tab"
fi

source "${CARGO_HOME}/env"
source "${NVM_DIR}/nvm.sh"
