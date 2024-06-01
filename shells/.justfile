alias f := flatpaks

flatpaks:
    #!/usr/bin/env bash

    flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists --user gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo

    flatpak install flathub -y --user \
      ca.desrt.dconf-editor \
      com.brave.Browser \
      com.logseq.Logseq \
      com.discordapp.Discord \
      com.github.tchx84.Flatseal \
      org.keepassxc.KeePassXC \
      org.gnome.Fractal \
      de.haeckerfelix.Fragments \
      io.github.celluloid_player.Celluloid \
      org.mozilla.Thunderbird \
      md.obsidian.Obsidian \
      net.mkiol.SpeechNote \
      com.github.wwmm.easyeffects \

    flatpak install -y --user org.gnome.Ptyxis.Devel

# kdeplasma-extensions:
#     echo "Installing Dynamic Workspaces like GNOME"
#     git clone https://github.com/d86leader/dynamic_workspaces.git
#     cd dynamic_workspaces
#     kpackagetool6 --type KWin/Script --install .
#     echo "Now install Panel Colorizer"

gnome-extensions:
    xdg-open https://extensions.gnome.org/extension/615/appindicator-support/
    xdg-open https://extensions.gnome.org/extension/5500/auto-activities/
    xdg-open https://extensions.gnome.org/extension/3193/blur-my-shell/
    xdg-open https://extensions.gnome.org/extension/517/caffeine/
    xdg-open https://extensions.gnome.org/extension/307/dash-to-dock/
    xdg-open https://extensions.gnome.org/extension/6072/fullscreen-to-empty-workspace/
    xdg-open https://extensions.gnome.org/extension/5410/grand-theft-focus/
    xdg-open https://extensions.gnome.org/extension/1319/gsconnect/
    xdg-open https://extensions.gnome.org/extension/545/hide-top-bar/
    xdg-open https://extensions.gnome.org/extension/2992/ideapad/
    xdg-open https://extensions.gnome.org/extension/2236/night-theme-switcher/
    xdg-open https://extensions.gnome.org/extension/4687/server-status-indicator/

alias q := quadlets

quadlets:
    systemctl --user daemon-reload
    systemctl --user enable --now podman-auto-update.timer
    systemctl --user start syncthing-quadlet
    systemctl --user start ollama-quadlet
    systemctl --user start open-webui-quadlet

brew:
    #!/usr/bin/env bash
    # This step is usually run my any of the shell dotfiles

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    brew bundle

    eval "$(fnm env --use-on-cd)"
    fnm install --lts
    corepack enable pnpm

cargo:
    #!/usr/bin/env bash
    # This step is usually run my any of the shell dotfiles

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # This has to be kept on sync with /etc/environment, ~/.zshenv and ~/.bash_profile sadly
    [[ -f "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env" 

java:
    #!/usr/bin/env bash
    # This step is usually run my any of the shell dotfiles

    curl -s "https://get.sdkman.io?rcupdate=false" | bash
    [[ -s "$SDKMAN_DIR" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
    sdk install java

distroboxes:
    distrobox assemble create

bios:
    systemctl reboot --firmware-setup

shutdown-bios:
    systemctl poweroff --firmware-setup
