flatpaks-kinoite:
	#!/usr/bin/env bash

	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	flatpak install flathub -y \
		com.brave.Browser \
		com.discordapp.Discord \
		com.github.wwmm.easyeffects \
		com.google.Chrome \
		com.logseq.Logseq \
		im.riot.Riot \
		io.mpv.Mpv \
		md.obsidian.Obsidian \
		net.mkiol.SpeechNote \
		org.getmonero.Monero \
		org.kde.kclock \
		org.kde.krita \
		org.keepassxc.KeePassXC \
		org.mozilla.Thunderbird \
		org.qbittorrent.qBittorrent \
		org.telegram.desktop \
		org.videolan.VLC

kde-plasma-extensions:
	#!/usr/bin/env bash

	git clone --depth 1 https://github.com/zeroxoneafour/polonium
	cd polonium
	make

	cd ..
	git clone --depth 1 https://github.com/Ubiquitine/temporary-virtual-desktops
	cd temporary-virtual-desktops
	kpackagetool6 --type KWin/Script --install .

flatpaks-gnome:
	#!/usr/bin/env bash

	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo

	flatpak install flathub -y \
		ca.desrt.dconf-editor \
		com.discordapp.Discord \
		com.github.finefindus.eyedropper \
		com.github.flxzt.rnote \
		com.github.huluti.Curtail \
		com.github.tchx84.Flatseal \
		com.github.tenderowl.frog \
		com.github.wwmm.easyeffects \
		com.google.Chrome \
		com.logseq.Logseq \
		de.haeckerfelix.Fragments \
		io.github.celluloid_player.Celluloid \
		md.obsidian.Obsidian \
		net.mkiol.SpeechNote \
		org.getmonero.Monero \
		org.gnome.Fractal \
		org.gnome.World.PikaBackup \
		org.gnome.seahorse.Application \
		org.inkscape.Inkscape \
		org.kde.krita \
		org.keepassxc.KeePassXC \
		org.mozilla.Thunderbird \
		org.nickvision.tubeconverter \
		org.videolan.VLC \
		re.sonny.Junction

	flatpak install gnome-nightly -y org.gnome.Ptyxis.Devel

# flatpak run --command=gsettings org.gnome.Epiphany set org.gnome.Epiphany.web:/org/gnome/epiphany/web/ enable-webextensions true
# 	org.gnome.Epiphany \
# org.gnome.World.Secrets \
# org.gnome.Fractal \
# org.telegram.desktop

gnome-extensions:
	#!/usr/bin/env bash

	# xdg-open https://extensions.gnome.org/extension/3843/just-perfection/
	# xdg-open https://extensions.gnome.org/extension/307/dash-to-dock/
	# xdg-open https://extensions.gnome.org/extension/2992/ideapad/
	# xdg-open https://extensions.gnome.org/extension/2236/night-theme-switcher/
	# xdg-open https://extensions.gnome.org/extension/6343/window-gestures/
	# xdg-open https://extensions.gnome.org/extension/5060/xremap/
	# xdg-open https://extensions.gnome.org/extension/352/middle-click-to-close-in-overview/
	# xdg-open https://extensions.gnome.org/extension/7065/tiling-shell/
	# xdg-open https://extensions.gnome.org/extension/4481/forge/
	# xdg-open https://extensions.gnome.org/extension/779/clipboard-indicator/
	# xdg-open https://extensions.gnome.org/extension/517/caffeine/
	# xdg-open https://extensions.gnome.org/extension/615/appindicator-support/
	# xdg-open https://extensions.gnome.org/extension/4158/gnome-40-ui-improvements/
	# xdg-open https://extensions.gnome.org/extension/2114/order-gnome-shell-extensions/
	# xdg-open https://extensions.gnome.org/extension/4007/alttab-mod/
	# xdg-open https://extensions.gnome.org/extension/2896/messaging-menu/

	xdg-open https://extensions.gnome.org/extension/5500/auto-activities/
	xdg-open https://extensions.gnome.org/extension/3193/blur-my-shell/
	xdg-open https://extensions.gnome.org/extension/3396/color-picker/
	xdg-open https://extensions.gnome.org/extension/2817/crypto-price-tracker/
	xdg-open https://extensions.gnome.org/extension/6072/fullscreen-to-empty-workspace/
	xdg-open https://extensions.gnome.org/extension/3956/gnome-fuzzy-app-search/
	xdg-open https://extensions.gnome.org/extension/5410/grand-theft-focus/
	xdg-open https://extensions.gnome.org/extension/1319/gsconnect/
	xdg-open https://extensions.gnome.org/extension/7083/pin-it/
	xdg-open https://extensions.gnome.org/extension/1336/run-or-raise/
	xdg-open https://extensions.gnome.org/extension/10/windownavigator/

battery-conservation-mode-on:
	echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode

battery-conservation-mode-off:
	echo 0 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode

purge-docker-containers:
	#!/usr/bin/env bash

	docker stop $(docker ps -q)
	docker rm $(docker ps -a -q)
	docker volume rm $(docker volume ls -q)
	docker rmi $(docker images -q)
	# docker network rm $(docker network ls | grep 'bridge\|host\|none' -v | awk '{print $1}')

user-groups:
	#!/usr/bin/env bash

	echo 'Adding the current user to the "docker" group'
	grep -E '^docker:' /usr/lib/group | sudo tee -a /etc/group
	sudo usermod -aG docker $USER

	echo 'Adding the current user to the "input" group'
	grep -E '^input:' /usr/lib/group | sudo tee -a /etc/group
	sudo usermod -aG input $USER

alias q := quadlets

quadlets:
	#!/usr/bin/env bash

	systemctl --user daemon-reload
	systemctl --user enable --now podman-auto-update.timer
	systemctl --user start syncthing-quadlet
	systemctl --user start ollama-quadlet
	systemctl --user start open-webui-quadlet

stow-dotfiles:
	#!/usr/bin/env bash

	cd ~/Documents/Repositories/dotfiles
	./.dotfiles.sh

brew-setup:
	#!/usr/bin/env bash
	# This step is usually run my any of the shell dotfiles

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

	brew bundle

	eval "$(fnm env --use-on-cd)"
	fnm install --lts
	corepack enable pnpm

rust-setup:
	#!/usr/bin/env bash
	# This step is usually run my any of the shell dotfiles

	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

	# This has to be kept on sync with /etc/environment, ~/.zshenv and ~/.bash_profile sadly
	[[ -f "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env" 

	rustup component add clippy
	rustup component add rustfmt

java-setup:
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

update:
	rpm-ostree upgrade
	flatpak upgrade
	distrobox upgrade --all
