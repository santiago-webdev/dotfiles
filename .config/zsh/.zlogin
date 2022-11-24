{
    # Compile zcompdump, if modified, to increase startup speed.
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zcompile "$zcompdump"
    fi
} &!

typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH # Automatically remove duplicates from these arrays

source "${CARGO_HOME}/env"
source "${NVM_DIR}/nvm.sh"
