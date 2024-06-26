flatpaks-kinoite:
	#!/usr/bin/env bash

	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	flatpak install flathub -y \
		com.brave.Browser \
		com.discordapp.Discord \
		com.github.wwmm.easyeffects \
		com.logseq.Logseq \
		md.obsidian.Obsidian \
		net.mkiol.SpeechNote \
		org.keepassxc.KeePassXC \
		org.mozilla.Thunderbird \
		org.videolan.VLC \
		io.mpv.Mpv \
		org.qbittorrent.qBittorrent \
		im.riot.Riot \

flatpaks-gnome:
	#!/usr/bin/env bash

	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo

	flatpak install flathub -y \
	com.brave.Browser \
		com.discordapp.Discord \
		com.github.wwmm.easyeffects \
		com.logseq.Logseq \
		md.obsidian.Obsidian \
		net.mkiol.SpeechNote \
		org.keepassxc.KeePassXC \
		org.mozilla.Thunderbird \
		com.github.tchx84.Flatseal \
		com.mattjakeman.ExtensionManager \
		de.haeckerfelix.Fragments \
		io.github.celluloid_player.Celluloid \
		com.github.finefindus.eyedropper \
		com.github.tenderowl.frog \
		org.gnome.Fractal \
		org.gnome.seahorse.Application \
		ca.desrt.dconf-editor \
		org.gnome.World.Secrets \

	# org.gnome.Epiphany \
	# org.videolan.VLC \
	# io.mpv.Mpv \
	# org.nickvision.money \
	# org.nickvision.tubeconverter
	# org.inkscape.Inkscape \
	# flatpak run --command=gsettings org.gnome.Epiphany set org.gnome.Epiphany.web:/org/gnome/epiphany/web/ enable-webextensions true

	flatpak install gnome-nightly -y org.gnome.Ptyxis.Devel

gnome-extensions:
	xdg-open https://extensions.gnome.org/extension/615/appindicator-support/
	xdg-open https://extensions.gnome.org/extension/5500/auto-activities/
	xdg-open https://extensions.gnome.org/extension/3193/blur-my-shell/
	xdg-open https://extensions.gnome.org/extension/517/caffeine/
	xdg-open https://extensions.gnome.org/extension/779/clipboard-indicator/
	xdg-open https://extensions.gnome.org/extension/3396/color-picker/
	xdg-open https://extensions.gnome.org/extension/307/dash-to-dock/
	xdg-open https://extensions.gnome.org/extension/6072/fullscreen-to-empty-workspace/
	xdg-open https://extensions.gnome.org/extension/5410/grand-theft-focus/
	xdg-open https://extensions.gnome.org/extension/1319/gsconnect/
	xdg-open https://extensions.gnome.org/extension/2992/ideapad/
	xdg-open https://extensions.gnome.org/extension/2236/night-theme-switcher/
	xdg-open https://extensions.gnome.org/extension/6343/window-gestures/
	xdg-open https://extensions.gnome.org/extension/1336/run-or-raise/
	xdg-open https://extensions.gnome.org/extension/5060/xremap/
	xdg-open https://extensions.gnome.org/extension/352/middle-click-to-close-in-overview/

battery-conservation-mode-on:
	echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode

battery-conservation-mode-off:
	echo 0 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode

alias q := quadlets

quadlets:
	systemctl --user daemon-reload
	systemctl --user enable --now podman-auto-update.timer
	systemctl --user start syncthing-quadlet
	systemctl --user start ollama-quadlet
	systemctl --user start open-webui-quadlet

stow-dotfiles:
	#!/usr/bin/env bash

	cd ~/Public/dotfiles
	./.dotfiles.sh

configure-keymaps:
	echo "Beware, this can break updates, since you'll be mutating /etc files and cargo has to be installed"
	echo "Dotfiles for xremap are in my dotfiles repo, and they need to be stow before running this step"
	# cargo install xremap --features gnome
	# cargo install xremap --features kde
	grep -E '^input:' /usr/lib/group | sudo tee -a /etc/group
	sudo usermod -aG input $USER
	echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/input.rules

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

update:
	flatpak upgrade
	distrobox upgrade --all
	rpm-ostree upgrade
