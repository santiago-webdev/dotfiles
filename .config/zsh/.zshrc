autoload -Uz colors && colors

# Completion settings
autoload -Uz compinit # Compinit
for dump in $ZDOTDIR/.zcompdump(N.mh+12); do # Twice a day it's updated
  compinit
done
compinit -C # Basic auto/tab complete:
_comp_options+=(globdots) # Include hidden files.

# Options
setopt MULTIOS # Perform implicit tees or cats when multiple redirections are attempted
setopt ALIASES # Enable the use of aliases
setopt PROMPT_SUBST # Let the prompt substite variables, without this the prompt will not work
setopt BRACE_CCL # Allow brace character class list expansion
setopt COMPLETE_IN_WORD # Complete from both ends of a word.
setopt ALWAYS_TO_END # Move cursor to the end of a completed word.
setopt CORRECT # Turn on corrections
setopt EXTENDEDGLOB NOMATCH MENUCOMPLETE
setopt INTERACTIVE_COMMENTS # Enable comments in interactive shell
setopt HASH_LIST_ALL # Whenever a command completion is attempted, make sure the entire command path is hashed first.
setopt RM_STAR_WAIT # Options for the rm command, avoids hitting yes as a reflex. RM_STAR_SILENT
setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt AUTOPARAMSLASH
setopt SHARE_HISTORY
setopt AUTO_CD # Automatically cd into typed directory without using cd
setopt AUTO_PUSHD # Push the current directory visited on the stack.
setopt CDABLE_VARS
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT # Do not print the directory stack after pushd or popd.
setopt AUTO_RESUME # Attempt to resume existing job before creating a new process.
setopt NOTIFY # Report status of background jobs immediately.
setopt NO_HUP # Don't kill jobs on shell exit.

# Unsert Options
unsetopt BG_NICE # Don't run all background jobs at a lower priority.
unsetopt BEEP # Disable bell, no sound on error

# History file settings
HISTFILE=${ZDOTDIR}/.hist
SAVEHIST=1000000
HISTSIZE=${SAVEHIST}+33

# Modules
zmodload zsh/complist
zmodload zsh/deltochar
zmodload zsh/mathfunc
zmodload zsh/parameter
autoload zcalc
autoload zmv

source "${ZDOTDIR}/utils.zsh" # Utils

PS1="%n%F{green}@%f%{$reset_color%}%m%F{blue} %3~%f%{$reset_color%}%F{yellow} ﴱ %{$reset_color%}"
RPS1='%{$reset_color%} $(check_last_exit_code) $vcs_info_msg_0_%{$reset_color%}'

# Alias, functions and keymaps
alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias cd-="cd -"
alias cp="cp -HpRiv"
alias mv="mv -iv"
# alias rm="rm -v" # Zap shows removed '/home/st/.local/share/zap/installed_plugins' for some reason
alias ip="ip --color=auto"
alias mine='sudo chown -R "$USER":"$USER" .'
alias -g DN=/dev/null
alias -g H="| head"
alias -g S="| sort"
alias -g T="| tail"
alias -g X="| xargs"
alias -g PIPE="|"
alias df="df -h -P --total --exclude-type=devtmpfs 2>/dev/null"
alias du="du -h"
alias free="free -m"
alias n="nvim"

# Git
alias -g ga="git add"
alias -g gi="git init"
alias -g gaa="git add --all"
alias -g gco="git commit -v -m"
alias -g gaaco="git add --all && git commit -v -m"
alias -g gaac="git add --all && git commit"
alias -g gpush="git push"
alias -g gpull="git pull"
alias -g gpullall="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;"
alias -g gd="git diff"
alias -g gc="git checkout"
alias -g gl="git log"
alias -g gs="git status"
alias -g gits="git stash -u"
alias -g gitsp="git stash pop"
gcs ()
{
  # git clone --depth=1 "$@" && cd
  git clone --depth=1 "$@"
}

if type exa > /dev/null 2>&1; then
  alias e="exa -lah --time-style=long-iso --icons --colour-scale --group-directories-first --git"
  alias teg='exa \
    -lah \
    --icons \
    --colour-scale \
    --group-directories-first \
    -T -L4 \
    --git-ignore \
    --git -I ".git|.gitignore|.styluaignore|.stylua.toml|README.*|LICENSE"'
else
  alias e='ls -lAhX --group-directories-first --color=auto'
  alias teg='ls -F --color=auto'
fi

if type rg > /dev/null 2>&1; then
  alias -g G="| rg"
else
  alias -g G="| grep"
  alias grep="grep --color"
fi

function myip() { echo "Your ip is:"; curl ipinfo.io/ip } # Get your public ip
function timezsh() { for i in $(seq 1 10); do time zsh -i -c exit; done } # Time zsh startup time
function run() { "${@}" < /dev/null &> /dev/null &; disown } # Send command into background and disown

# Clear the screen and re-run the last command on your history
function last-command() {
  clear
  zle up-history
  zle accept-line
}
zle -N last-command
# bindkey '^[r' last-command # <A-r>
bindkey -M viins '^R' last-command # <C-r>
bindkey -M vicmd '^R' last-command # <C-r>

# Enabling shift-tab for reverse completion
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Switch between neovim and the terminal with just <C-z>
function _zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg

# Run the command but hold the contents on the prompt
bindkey -M viins '^\' accept-and-hold # Vi insert mode
bindkey -M vicmd '^\' accept-and-hold # Vi command mode

# Edit the command with an external text editor with <A-v> in insert mode
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^[v' edit-command-line

# Search like in vim with /
bindkey -M vicmd '/' history-incremental-search-backward

function change_window_title() {
  case $TERM in
    xterm*)
      function precmd() {
        print -Pn - '\e]0;%~\a'
      }
      ;;
  esac
}

function show_context() {
  if [[ -f "/run/.containerenv" ]]; then # We are inside container.
    exa -1ah --icons --colour-scale --group-directories-first -T -L1
  else
    ls -1a
  fi
}

# Load some functions
autoload change_window_title
autoload show_context
gitstatus

fpath+="${ZDOTDIR}/completion" # Other completions
# fpath+="${ZDOTDIR}/plugins/zsh-completions/src" # Zsh-completions plugin

chpwd_functions+=("show_context")
chpwd_functions+=("enter_venv")

printf '\n%.0s' {1..100} # Make the prompt show up at the bottom of the terminal
PS1=$'${(r:$COLUMNS::━:)}'$PS1 # Puts a separation between each prompt

# `exit` == <A-q>
exit-proc() { exit; zle accept-line }
zle -N exit-proc
bindkey -M viins '^[q' exit-proc # <A-q>
bindkey -M vicmd '^[q' exit-proc # <A-q>

# Zap
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh" ||
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh)
