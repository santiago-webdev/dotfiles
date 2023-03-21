#!/usr/bin/env bash

declare KDE_CONF="$HOME/workspace/private_dotfiles/kdeconf"
mkdir -p "$KDE_CONF"

case "$1" in
  backup)
    cp -r "$HOME/.config/gtk-3.0" "$KDE_CONF"
    cp -r "$HOME/.config/gtk-4.0" "$KDE_CONF"
    cp -r "$HOME/.config/KDE" "$KDE_CONF"
    cp -r "$HOME/.config/kde.org" "$KDE_CONF"
    cp -r "$HOME/.config/plasma-workspace" "$KDE_CONF"
    cp -r "$HOME/.config/xsettingsd" "$KDE_CONF"
    cp -r "$HOME/.config/akregatorrc" "$KDE_CONF"
    cp -r "$HOME/.config/baloofilerc" "$KDE_CONF"
    cp -r "$HOME/.config/bluedevilglobalrc" "$KDE_CONF"
    cp -r "$HOME/.config/dolphinrc" "$KDE_CONF"
    cp -r "$HOME/.config/gtkrc" "$KDE_CONF"
    cp -r "$HOME/.config/gtkrc-2.0" "$KDE_CONF"
    cp -r "$HOME/.config/gwenviewrc" "$KDE_CONF"
    cp -r "$HOME/.config/kactivitymanagerd-statsrc" "$KDE_CONF"
    cp -r "$HOME/.config/kactivitymanagerdrc" "$KDE_CONF"
    cp -r "$HOME/.config/kcminputrc" "$KDE_CONF"
    cp -r "$HOME/.config/kconf_updaterc" "$KDE_CONF"
    cp -r "$HOME/.config/kded5rc" "$KDE_CONF"
    cp -r "$HOME/.config/kdeglobals" "$KDE_CONF"
    cp -r "$HOME/.config/kglobalshortcutsrc" "$KDE_CONF"
    cp -r "$HOME/.config/khotkeysrc" "$KDE_CONF"
    cp -r "$HOME/.config/kmixrc" "$KDE_CONF"
    cp -r "$HOME/.config/konsolerc" "$KDE_CONF"
    cp -r "$HOME/.config/kscreenlockerrc" "$KDE_CONF"
    cp -r "$HOME/.config/ksmserverrc" "$KDE_CONF"
    cp -r "$HOME/.config/ksplashrc" "$KDE_CONF"
    cp -r "$HOME/.config/ktimezonedrc" "$KDE_CONF"
    cp -r "$HOME/.config/kwinrc" "$KDE_CONF"
    cp -r "$HOME/.config/kwinrulesrc" "$KDE_CONF"
    cp -r "$HOME/.config/kxkbrc" "$KDE_CONF"
    cp -r "$HOME/.config/plasma-localerc" "$KDE_CONF"
    cp -r "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" "$KDE_CONF"
    cp -r "$HOME/.config/plasmashellrc" "$KDE_CONF"
    cp -r "$HOME/.config/powermanagementprofilesrc" "$KDE_CONF"
    cp -r "$HOME/.config/spectaclerc" "$KDE_CONF"
    cp -r "$HOME/.config/systemsettingsrc" "$KDE_CONF"
    cp -r "$HOME/.config/Trolltech.conf" "$KDE_CONF"
    cp -r "$HOME/.config/user-dirs.dirs" "$KDE_CONF"
    cp -r "$HOME/.config/user-dirs.locale" "$KDE_CONF"
    cp -r "$HOME/.config/okularrc" "$KDE_CONF"
    cp -r "$HOME/.config/okularpartrc" "$KDE_CONF"
    cp -r "$HOME/.config/krunnerrc" "$KDE_CONF"
    ;;
  restore)
    if [ -z "$(ls -A "$KDE_CONF")" ]; then
      echo "Directory $KDE_CONF is empty."
    else
      rsync --verbose --recursive --ignore-times "$KDE_CONF" "$XDG_CONFIG_HOME"
    fi
    ;;
  *)
    echo "Usage: $0 {restore|backup}"
    ;;
esac
