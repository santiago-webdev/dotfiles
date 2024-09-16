# Completion {{{
autoload -U compinit
compinit -C
for dump in $ZDOTDIR/.zcompdump(N.mh+12); do # Twice a day it's updated
  compinit
done
# compinit -C # Basic auto/tab complete:
_comp_options+=(globdots) # Include hidden files.

# zstyle ':completion:*' completer _expand_alias _complete _ignored # Expand aliases with TAB
# zstyle ':completion:*' regular true
# zstyle ':completion:*:git-checkout:*' sort false # disable sort when completing `git checkout`
# zstyle ':completion:*:descriptions' format '[%d]' # set descriptions format to enable group support
# zstyle ':completion:*' format %F{yellow}-- %B%U%{$__DOTS[ITALIC_ON]%}%d%{$__DOTS[ITALIC_OFF]%}%b%u --%f
# zstyle ':compinstall:filename' '/home/st/.config/zsh/.zshrc'
# zstyle ':completion:*:*:*:*:*' menu select=3 # If there's less than 3 items it will use normal tabs
# zstyle ':completion:*:history-words' menu yes # Activate menu
# zstyle ':completion:*:matches' group 'yes'
# zstyle ':completion:*:options' description 'yes'
# zstyle ':completion:*:options' auto-description '%d'
# zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
# zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
# zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
# zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' verbose yes
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# # Match elements by typing any part of it, sort of fussy completion.
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Za-z}' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':autocomplete:*' min-delay 0.0  # Float
# zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' menu select
# I don't know what ^^^this^^^ does anymore
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# }}}
# Settings {{{
autoload -Uz colors && colors

# setopt ALIASES # Enable the use of aliases
setopt MULTIOS # Perform implicit tees or cats when multiple redirections are attempted
setopt PROMPT_SUBST # Let the prompt substite variables, without this the prompt will not work
# setopt BRACE_CCL # Allow brace character class list expansion
# # Complete from both ends of a word. Completion for elements when you hit TAB at the
# # start of words. Hitting tab at: |.toml will auto-complete to .stylua.toml |
# setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END # Move cursor to the end of a completed word.
# setopt CORRECT # Turn on corrections
setopt EXTENDEDGLOB NOMATCH MENUCOMPLETE
# setopt INTERACTIVE_COMMENTS # Enable comments in interactive shell
# setopt HASH_LIST_ALL # Whenever a command completion is attempted, make sure the entire command path is hashed first.
# setopt RM_STAR_WAIT # Options for the rm command, avoids hitting yes as a reflex. RM_STAR_SILENT
# setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
# setopt HIST_EXPIRE_DUPS_FIRST
# setopt HIST_IGNORE_ALL_DUPS
# setopt HIST_IGNORE_SPACE
# setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
# setopt AUTOPARAMSLASH
setopt SHARE_HISTORY
setopt AUTO_CD # Automatically cd into typed directory without using cd
setopt AUTO_PUSHD # Push the current directory visited on the stack.
setopt CDABLE_VARS
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT # Do not print the directory stack after pushd or popd.
setopt AUTO_RESUME # Attempt to resume existing job before creating a new process.
setopt NOTIFY # Report status of background jobs immediately.
setopt NO_HUP # Don't kill jobs on shell exit.
setopt GLOBDOTS

# Unsert Options
unsetopt BG_NICE # Don't run all background jobs at a lower priority.
unsetopt BEEP # Disable bell, no sound on error

# History file settings
HISTFILE=${ZDOTDIR}/.zsh_history
# HISTFILE=${HOME}/.bash_history
SAVEHIST=1000000
HISTSIZE=${SAVEHIST}+33
# }}}
# Prompt {{{
# Git Status
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn

# Setup a hook that runs before every ptompt.
function precmd_vcs_info() {
  vcs_info
}
precmd_functions+=(precmd_vcs_info)

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st

function +vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep '??' &> /dev/null ; then
      hook_com[staged]+='!' # Signify new files with a bang
  fi
}

function +vi-git-st() {
  local ahead behind
  local -a gitstatus

  ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
  (( $ahead )) && gitstatus+=( "󰐗 ${ahead} " )

  behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
  (( $behind )) && gitstatus+=( "󰍶 ${behind} " )

  hook_com[misc]+=${(j:/:)gitstatus}
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[red]%}%m%u%c%{$fg[yellow]%} %{$fg[magenta]%}%b"

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

# Check for /run/.containerenv to determine if running inside a container
if [ -f /run/.containerenv ]
then
    CONTAINER_INDICATOR="📦 "
else
    CONTAINER_INDICATOR="🖥️  "
fi

# PS1='%n%F{white}@%{$reset_color%}%m %F{white}%1~ %{$reset_color%}%F{cyan}${CONTAINER_INDICATOR}'
PS1='%n %F{cyan}%1~ %{$reset_color%}%F{cyan}${CONTAINER_INDICATOR}'
RPS1='$(check_last_exit_code) ${vcs_info_msg_0_} %{$reset_color%}'

# This has to go after the prompt, else it gets overwritten
# printf '\n%.0s' {1..100} # Make the prompt show up at the bottom of the terminal
# PS1=$'${(r:$COLUMNS::─:)}'$PS1 # Puts a separation between each prompt
# }}}
# Aliases {{{
alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias cd-="cd -"
alias mkdir="mkdir -p"
alias cp="cp -HpRiv"
alias mv="mv -iv"
alias rm="rm -v"
alias ip="ip --color=auto"
alias mine='sudo chown -R "$USER":"$USER" .'
alias -g DN="&> /dev/null"
alias -g H="| head"
alias -g S="| sort"
alias -g T="| tail"
alias -g X="| xargs"
alias -g PIPE="|"
alias grep="grep --color"
alias -g G="| rg"
alias df="df -h -P --total --exclude-type=devtmpfs 2>/dev/null"
alias du="du -h"
alias free="free -m"
alias n="nvim"
alias g="git"
alias d="distrobox-host-exec"
alias lsd="eza -lah \
  --time-style=long-iso \
  --icons \
  --colour-scale \
  --group-directories-first \
  --git \
  --git-ignore"
alias lst="eza \
  -1ah \
  --icons \
  --time-style=long-iso \
  --colour-scale \
  --group-directories-first \
  -T -L6 \
  --git-ignore \
  --git -I \
  'node_modules|.node_modules|.git|.gitignore|.styluaignore|.stylua.toml|README.*|LICENSE'"
alias lstd="eza \
  -lah \
  --icons \
  --time-style=long-iso \
  --colour-scale \
  --group-directories-first \
  -T -L6 \
  --git-ignore \
  --git -I \
  'node_modules|.node_modules|.git|.gitignore|.styluaignore|.stylua.toml|README.*|LICENSE'"

if [[ -n "$WSL_DISTRO_NAME" ]]; then
  alias podman='podman-remote-static-linux_amd64'
fi

# # Open file extensions with neovim
# alias -s txt=$EDITOR
# alias -s svelte=$EDITOR
# alias -s js=$EDITOR
# alias -s css=$EDITOR
# alias -s html=$EDITOR
# alias -s md=$EDITOR
# alias -s py=$EDITOR
# alias -s json=$EDITOR
# alias -s jsonc=$EDITOR
# }}}
# Builtin Modules {{{
zmodload zsh/complist
zmodload zsh/deltochar
zmodload zsh/mathfunc
zmodload zsh/parameter
autoload zcalc
autoload zmv
autoload -Uz add-zsh-hook
autoload -U select-word-style
select-word-style bash
# }}}
# Hooks {{{
function show_context() {
  lsd
}

function enter_venv() {
  if [[ -z "${VIRTUAL_ENV}" ]]
  then
    if [[ -d ./.venv ]]
    then
      source ./.venv/bin/activate
    fi
  else
    parentdir="$(dirname "$VIRTUAL_ENV")"
    if [[ "$PWD"/ != "$parentdir"/* ]]
    then
      deactivate
    fi
  fi
}

add-zsh-hook chpwd show_context
add-zsh-hook chpwd enter_venv
# }}}
# Keybind {{{
# `exit` == <A-q>
exit-proc() { exit; zle accept-line }
zle -N exit-proc
bindkey -M viins '^[q' exit-proc # <A-q>
bindkey -M vicmd '^[q' exit-proc # <A-q>

# Clear the screen and re-run the last command on your history
function last-command() {
  clear
  zle up-history
  zle accept-line
}
zle -N last-command
bindkey '^[r' last-command # <A-r>
bindkey -M viins '^[r' last-command # <A-r>
bindkey -M vicmd '^[r' last-command # <A-r>

bindkey -M menuselect '^[[Z' reverse-menu-complete # Enabling shift-tab for reverse completion

# Switch between currently running process and the terminal with just <C-z>
function _zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
# bindkey '^Z' _zsh_cli_fg
bindkey -M viins '^Z' _zsh_cli_fg # <C-r>
bindkey -M vicmd '^Z' _zsh_cli_fg # <C-r>

# Run the command but hold the contents on the prompt
bindkey -M viins '^\' accept-and-hold # Vi insert mode
bindkey -M vicmd '^\' accept-and-hold # Vi command mode

# Open the prompt in your editor with <C-o>
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M viins '^o' edit-command-line
bindkey -M vicmd '^o' edit-command-line

bindkey -M vicmd '/' history-incremental-search-backward # Search like in vim with /
# }}}
# Commands {{{
function cds { cd $(basename $(pwd)) $@ }
function tcn { mv -f $@ $XDG_TRASH_DIR }
function myip() { echo "Your ip is:"; curl ipinfo.io/ip }
function timezsh() { for i in $(seq 1 10); do time zsh -i -c exit; done }
function run() { "${@}" < /dev/null &> /dev/null &; disown }

# Extract files
function ex() {
  # Get the list of files to extract
  files=("$@")

  # Check if all files exist
  for file in "${files[@]}"; do
    if [ ! -f "$file" ]; then
      echo "'$file' is not a valid file"
      return 1
    fi
  done

  # Extract each file
  for file in "${files[@]}"; do
    case "$file" in
      *.tar.bz2) tar xjf "$file";;
      *.tar.gz) tar xzf "$file";;
      *.tar.xz) tar xJf "$file";;
      *.tar.zst) tar --use-compress-program=zstd -xvf "$file";; # Added for .tar.zst files
      *.bz2) bunzip2 "$file";;
      *.rar) unrar x "$file";;
      *.gz) gunzip "$file";;
      *.tar) tar xf "$file";;
      *.tbz2) tar xjf "$file";;
      *.tgz) tar xzf "$file";;
      *.zip) unzip "$file" -d $(basename "$file" .zip);;
      *.Z) uncompress "$file";;
      *.7z) 7z x "$file";;
      *) echo "'$file' cannot be extracted via ex";;
    esac
  done
}
# }}}
# Plugins {{{
if ! [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ]; then
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
  source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
  plug "romkatv/zsh-defer"
  exec zsh -l
fi

source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "romkatv/zsh-defer"
function defer_tooling() {
  plug "bilelmoussaoui/flatpak-zsh-completion"
  plug "zsh-users/zsh-completions"
  plug "zdharma-continuum/fast-syntax-highlighting"
  
  plug "zsh-users/zsh-history-substring-search"
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
  
  plug "zsh-users/zsh-autosuggestions"
  # bindkey -M vicmd '^[a' autosuggest-accept
  # bindkey -M viins '^[a' autosuggest-execute
  
  plug "hlissner/zsh-autopair"
  zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'bat --color=always --italic-text=always $realpath'
  zstyle ':fzf-tab:complete:cp:*' fzf-preview 'bat --color=always --italic-text=always $realpath'
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1a --colour-scale --icons --group-directories-first --color=always $realpath'
  
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
    export FZF_DEFAULT_OPTS="--color=fg:#77a8c3,bg:-1,hl:#3e9831,fg+:#cbccc6,bg+:#434c5e,hl+:#af87ff \
      --color=dark \
      --color=info:#ea9d34,prompt:#af87ff,pointer:#cb6283,marker:#cb6283,spinner:#ff87d7 \
      --sort \
      --preview-window=right:$WIDTHVAR \
      --bind '?:toggle-preview' \
      --border rounded"
  }
  
  set_default_opts && trap 'check_terminal_size' WINCH
  plug "Aloxaf/fzf-tab"
  
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }
  
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
  
  # plug "zap-zsh/vim"
  plug "softmoth/zsh-vim-mode"
  
  # Print tree structure in the preview window
  # export FZF_ALT_C_OPTS="
  #   --walker-skip .git,node_modules,target
  #   --preview 'tree -C {}'"
  # }}}
# Execute last {{{
  function change_window_title() {
    case $TERM in
      *)
        function precmd() {
          # print -Pn - '\e]0;%~\a'
          # Includes the hostname, which also is the name of the container
          print -Pn - '\e]0;%m:%~\a'
        }
        ;;
    esac
  }
  
  autoload -Uz change_window_title
  change_window_title

  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  if type brew &>/dev/null
    then
      FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

      autoload -Uz compinit
      compinit
  fi

  eval "$(fzf --zsh)"
  eval "$(fnm env --use-on-cd)"
  eval "$(zoxide init zsh)"
  source "$SDKMAN_DIR/bin/sdkman-init.sh"
  source "$CARGO_HOME/env"
}

zsh-defer defer_tooling

typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH # Automatically remove duplicates from these arrays
source "${HOME}/.zshenv"
# }}}
# vim:fdm=marker:fdl=0
