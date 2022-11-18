{
    # Compile zcompdump, if modified, to increase startup speed.
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zcompile "$zcompdump"
    fi
} &!

xdg-user-dirs-update --set DESKTOP "$HOME"/.local/Desktop > /dev/null 2>&1
xdg-user-dirs-update --set DOWNLOAD "$HOME"/.local/Downloads > /dev/null 2>&1
xdg-user-dirs-update --set TEMPLATES "$HOME"/.local/Templates > /dev/null 2>&1
xdg-user-dirs-update --set PUBLICSHARE "$HOME"/.local/Public > /dev/null 2>&1
xdg-user-dirs-update --set DOCUMENTS "$HOME"/.local/Documents > /dev/null 2>&1
xdg-user-dirs-update --set MUSIC "$HOME"/.local/Music > /dev/null 2>&1
xdg-user-dirs-update --set PICTURES "$HOME"/.local/Pictures > /dev/null 2>&1
xdg-user-dirs-update --set VIDEOS "$HOME"/.local/Videos > /dev/null 2>&1
