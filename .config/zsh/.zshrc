function source-file {
    if [[ -e "$1" ]]; then
        source "$1"
    fi
}

autoload -Uz colors && colors

# Zsh-defer
source-file "${ZDOTDIR}/plugins/zsh-defer/zsh-defer.plugin.zsh"

fpath=("${ZDOTDIR}/plugins/zsh-completions/src" $fpath) # Zsh-completions

_comp_options+=(globdots) # Include hidden files.
autoload -Uz compinit # Compinit
for dump in $ZDOTDIR/.zcompdump(N.mh+12); do # Twice a day it's updated
    compinit
done
compinit -C # Basic auto/tab complete:


stty stop undef # Disable <C-s> to freeze terminal.
typeset -A __DOTS
__DOTS[ITALIC_ON]=$'\e[3m'
__DOTS[ITALIC_OFF]=$'\e[23m'

zstyle ':completion:*' completer _expand_alias _complete _ignored # Expand aliases with TAB
zstyle ':completion:*:git-checkout:*' sort false # disable sort when completing `git checkout`
zstyle ':completion:*:descriptions' format '[%d]' # set descriptions format to enable group support
zstyle ':completion:*' format %F{yellow}-- %B%U%{$__DOTS[ITALIC_ON]%}%d%{$__DOTS[ITALIC_OFF]%}%b%u --%f
zstyle ':compinstall:filename' '/home/st/.config/zsh/.zshrc'
zstyle ':completion:*:*:*:*:*' menu select=3 # If there's less than 3 items it will use normal tabs
zstyle ':completion:*:history-words' menu yes # Activate menu
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':autocomplete:*' min-delay 0.0  # Float
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH # Automatically remove duplicates from these arrays

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
setopt AUTO_CD # Automatically cd into typed directory.
setopt AUTO_PUSHD # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT # Do not print the directory stack after pushd or popd.
setopt AUTO_RESUME # Attempt to resume existing job before creating a new process.
setopt NOTIFY # Report status of background jobs immediately.
setopt NO_HUP # Don't kill jobs on shell exit.
unsetopt BG_NICE # Don't run all background jobs at a lower priority.
unsetopt BEEP # Disable bell, no sound on error

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

# Vi mode, change cursor shape and prompt for different vi modes.
function cursor_shape {
    function zle-keymap-select {
        case $KEYMAP in
            vicmd) echo -ne '\e[1 q';; # Block, because vicmd implies it's in command mode
            viins|main) echo -ne '\e[5 q';; # Beam, because viins implies it's in insert mode
        esac
        vi_mode="${${KEYMAP/vicmd/${vi_cmd_mode}}/(main|viins)/${vi_ins_mode}}"
        zle reset-prompt
    }
    zle -N zle-keymap-select

    function zle-line-init {
        echo -ne "\e[5 q"
    }
    zle -N zle-line-init # Initial state of the shell when you open it. It's in insert mode, with the Beam cursor
    function preexec { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

    function TRAPINT {
        vi_mode=$vi_ins_mode
        return $(( 128 + $1 ))
    }

    vi_ins_mode=" "
    vi_cmd_mode="%{$fg[green]%} %{$reset_color%}"
    vi_mode=$vi_ins_mode
}
zle -N cursor_shape
autoload -Uz cursor_shape
cursor_shape

# Exit error code of the last command
function check_last_exit_code {
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
function gitstatus {
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git svn

    # Setup a hook that runs before every ptompt.
    function precmd_vcs_info {
        vcs_info
    }
    precmd_functions+=(precmd_vcs_info)

    zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

    function +vi-git-untracked {
        if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
            git status --porcelain | grep '??' &> /dev/null ; then
                hook_com[staged]+='!' # Signify new files with a bang
        fi
    }
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}❰%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%}❱"
}

zsh-defer gitstatus

printf '\n%.0s' {1..100}

PS1="%n%F{white}@%f%{$reset_color%}%m%F{white} %3~%f%{$reset_color%}%F{white}  %{$reset_color%}"
RPS1='$(check_last_exit_code) ${vi_mode} $vcs_info_msg_0_'

bindkey -v # Vi mode

# Alias, functions and keymaps
alias -g ...='../..'
alias -g ....='../../..'
alias -g cd-='cd -'
alias cp='cp -HpRiv'
alias mv='mv -iv'
alias rm='rm -v'
if type exa > /dev/null 2>&1; then
    alias e='exa -lah --time-style=long-iso --icons --colour-scale --group-directories-first --git'
    alias ee='exa -lah --icons --colour-scale --group-directories-first --git -T -L4'
else
    alias e='ls -lAhX --group-directories-first --color=auto'
    alias ee='ls -F --color=auto'
fi
alias plasma-restart='kquitapp5 plasmashell && sleep 8 && kstart5 plasmashell && sleep 8 && kwin_wayland --replace &'
alias ip='ip --color=auto'
alias mine='sudo chown -R $USER:$USER .'
alias -g DN=/dev/null
alias -g H='| head'
alias -g S='| sort'
alias -g T='| tail'
alias -g X='| xargs'
if type rg > /dev/null 2>&1; then
    alias -g G='| rg'
else
    alias -g G='| grep'
    alias grep='grep --color'
fi
alias -g PIPE='|'
alias df='df -h -P --total --exclude-type=devtmpfs 2>/dev/null'
alias du='du -h'
alias free='free -m'
alias -g wget="wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts"
alias -g sn='sudo -E nvim' # Open nvim with superuser privileges maintaining user configs
alias -g s='sudoedit'
alias txe='toolbox enter'
alias txr='toolbox run -c'
alias n="nice -20 nvim --listen $NVIMREMOTE"
# Package managers
alias pac='sudo pacman -Syu --noconfirm' # Update
alias pacinst='sudo pacman -S' # Install programs
alias pacparu='sudo pacman -Syyuu --noconfirm && paru' # Also update AUR packages
alias pacorphans='pacman -Qtdq' # Show orphans
alias pacremoveorphans='sudo pacman -Rns $(pacman -Qtdq)' # Remove orphan packages
# Git
alias -g ga='git add --all'
alias -g gco='git commit -v -m'
alias -g gaco='git add --all && git commit -v -m'
alias -g gpush='git push'
alias -g gpull='git pull'
alias -g gpullall='for i in */.git; do ( echo $i; cd $i/..; git pull; ); done'
alias -g gd='git diff'
alias -g gcb='git checkout -b'
alias -g gl='git log'
alias -g gs='git status'
alias -g gits='git stash'
alias -g gitsp='git stash pop'

function gclo {
    git clone --depth=1 "$@" &; disown
}

if type bat > /dev/null 2>&1; then
    themes=('1337' 'Coldark-Cold' 'Coldark-Dark' 'DarkNeon' 'Dracula' 'GitHub' 'Monokai Extended' 'Monokai Extended Bright' 'Monokai Extended Light' 'Monokai Extended Origin' 'Nord' 'OneHalfDark' 'OneHalfLight' 'Sublime Snazzy' 'TwoDark' 'Visual Studio Dark+' 'ansi' 'base16' 'base16-256' 'gruvbox-dark' 'gruvbox-light' 'zenburn')
    alias bat='bat --theme ${themes[RANDOM%${#themes[@]}]} --italic-text=always'
fi

function venv { NAME_ENV=$(basename $(pwd)); python -m venv .venv --prompt $NAME_ENV }
function myip { echo 'Your ip is:'; curl ipinfo.io/ip }
function timezsh { for i in $(seq 1 10); do time zsh -i -c exit; done }
function run { "${@}" < /dev/null &> /dev/null &; disown }

# Clear the screen and re-run the last command on your history
function last-command {
    clear
    zle up-history
    zle accept-line
}
zle -N last-command
# bindkey '^[r' last-command # <A-r>
bindkey -M viins '^R' last-command # <C-r>
bindkey -M vicmd '^R' last-command # <C-r>


function exit-proc { exit; zle accept-line }
zle -N exit-proc
bindkey '^[c' exit-proc # <A-c>

# Clone plugins repos
function clone-plugins {
    mkdir -p "${ZDOTDIR}/plugins"
    cd "${ZDOTDIR}/plugins"
    git clone --depth=1 git://github.com/zsh-users/zsh-completions.git
    git clone --depth=1 https://github.com/Aloxaf/fzf-tab
    git clone --depth=1 https://github.com/hlissner/zsh-autopair
    git clone --depth=1 https://github.com/romkatv/zsh-defer
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions
    git clone --depth=1 https://github.com/agkozak/zsh-z
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search
    git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting
}

# Extracting files
function ex {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1   ;;
            *.tar.gz)   tar xzf $1   ;;
            *.tar.xz)   tar xJf $1   ;;
            *.bz2)      bunzip2 $1   ;;
            *.rar)      unrar x $1   ;;
            *.gz)       gunzip $1    ;;
            *.tar)      tar xf $1    ;;
            *.tbz2)     tar xjf $1   ;;
            *.tgz)      tar xzf $1   ;;
            *.zip)      unzip $1     ;;
            *.Z)        uncompress $1;;
            *.7z)       7z x $1      ;;
            *)          echo "'$1' cannot be extracted via ex" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Change title of the window to the working directory
function change_title {
    case $TERM in
        xterm*)
            function precmd {
                print -Pn - '\e]0;%~\a'
            }
            ;;
    esac
}

zsh-defer change_title

bindkey -M menuselect '^[[Z' reverse-menu-complete # Enabling shift-tab for completion

function _zsh_cli_fg { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg

# Run the command but hold the contents on the prompt
bindkey -M viins '^\' accept-and-hold # Vi insert mode
bindkey -M vicmd '^\' accept-and-hold # Vi command mode

# Search with vim-like keybindings through autocompletion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

autoload -Uz edit-command-line # Edit the command line with an external editor
zle -N edit-command-line
bindkey '^[v' edit-command-line # Edit line with Alt+v in insert mode

bindkey -M vicmd '/' history-incremental-search-backward # Search like in vim

# Zsh-autosuggestions
zsh-defer source "${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey -M vicmd '^[a' autosuggest-accept
bindkey -M viins '^[a' autosuggest-execute

# Zsh-autopairs
zsh-defer source "${ZDOTDIR}/plugins/zsh-autopair/autopair.zsh"

# Fast-syntax-highlighting
zsh-defer source "${ZDOTDIR}/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# Zsh-history-substring-search
zsh-defer source "${ZDOTDIR}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Fzf-tab
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'bat --color=always --italic-text=always $realpath' # preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cp:*' fzf-preview 'bat --color=always --italic-text=always $realpath' # preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1a --colour-scale --icons --group-directories-first --color=always $realpath' # preview directory's content with exa when completing cd
function check_terminal_size {
    if [[ "$LINES $COLUMNS" != "$previous_lines $previous_columns" ]]; then
        set_default_opts
    fi
    previous_lines=$LINES
    previous_columns=$COLUMNS
}
function set_default_opts {
    HEIGHTVAR=$(($LINES/2))
    WIDTHVAR=$(($COLUMNS/2))
    zstyle ':fzf-tab:*' fzf-pad $HEIGHTVAR
    export FZF_DEFAULT_OPTS="
        --color=fg:#707a8c,bg:-1,hl:#3e9831,fg+:#cbccc6,bg+:#434c5e,hl+:#af87ff \
        --color=dark \
        --color=info:#ea9d34,prompt:#af87ff,pointer:#cb6283,marker:#cb6283,spinner:#ff87d7 \
        --sort \
        --preview-window=right:$WIDTHVAR \
        --bind '?:toggle-preview' \
        --border rounded"
}

set_default_opts && trap 'check_terminal_size' WINCH
zsh-defer source "${ZDOTDIR}/plugins/fzf-tab/fzf-tab.plugin.zsh"

zsh-defer source-file "${HOME}/.local/lib/sdkman/bin/sdkman-init.sh" # SDKMAN
zsh-defer source-file "${XDG_DATA_HOME}/cargo/env"
zsh-defer source-file "${NVM_DIR}/nvm.sh" # NVM
zsh-defer source-file "${XDG_DATA_HOME}/ghcup/env" # ghcup-env

# Actions when changing of directory
function list_all {
    emulate -L zsh;
    e # Check the alias to change the behaviour
}
function enter_venv {
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
# This array is run each time the directory is changed
chpwd_functions=(${chpwd_functions[@]} "list_all" "enter_venv")
