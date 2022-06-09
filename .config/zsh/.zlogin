{
    # Compile zcompdump, if modified, to increase startup speed.
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zcompile "$zcompdump"
    fi
} &!

xdg-user-dirs-update --set DESKTOP "$HOME"/.local/Desktop
xdg-user-dirs-update --set DOWNLOAD "$HOME"/.local/Downloads
xdg-user-dirs-update --set TEMPLATES "$HOME"/.local/Templates
xdg-user-dirs-update --set PUBLICSHARE "$HOME"/.local/Public
xdg-user-dirs-update --set DOCUMENTS "$HOME"/.local/Documents
xdg-user-dirs-update --set MUSIC "$HOME"/.local/Music
xdg-user-dirs-update --set PICTURES "$HOME"/.local/Pictures
xdg-user-dirs-update --set VIDEOS "$HOME"/.local/Videos
