flatpaks:
	#!/usr/bin/env bash

	flatpak install fedora -y \
		org.fedoraproject.MediaWriter \
		org.gnome.Calculator \
		org.gnome.Calendar \
		org.gnome.Characters \
		org.gnome.Connections \
		org.gnome.Contacts \
		org.gnome.Evince \
		org.gnome.Extensions \
		org.gnome.Logs \
		org.gnome.Loupe \
		org.gnome.Maps \
		org.gnome.NautilusPreviewer \
		org.gnome.Snapshot \
		org.gnome.TextEditor \
		org.gnome.Weather \
		org.gnome.baobab \
		org.gnome.clocks \
		org.gnome.font-viewer

	flatpak install flathub -y \
		ca.desrt.dconf-editor \
		ca.edestcroix.Recordbox \
		com.brave.Browser \
		com.discordapp.Discord \
		com.github.flxzt.rnote \
		com.google.Chrome \
		com.mattjakeman.ExtensionManager \
		com.microsoft.Edge \
		com.vivaldi.Vivaldi \
		io.github.celluloid_player.Celluloid \
		org.getmonero.Monero \
		org.gnome.Fractal \
		org.gnome.Polari \
		org.gnome.World.Secrets \
		org.keepassxc.KeePassXC \
		org.mozilla.Thunderbird \
		org.nicotine_plus.Nicotine \
		org.qbittorrent.qBittorrent \
		org.qbittorrent.qBittorrent \
		org.torproject.torbrowser-launcher \
		org.videolan.VLC \
		re.sonny.Junction

	flatpak install flathub -y \
		org.beeref.BeeRef \
		org.blender.Blender \
		org.inkscape.Inkscape \
		org.kde.krita \

gnome-extensions:
	#!/usr/bin/env bash

	xdg-open https://extensions.gnome.org/extension/5500/auto-activities/
	xdg-open https://extensions.gnome.org/extension/3193/blur-my-shell/
	xdg-open https://extensions.gnome.org/extension/517/caffeine/
	xdg-open https://extensions.gnome.org/extension/3396/color-picker/
	xdg-open https://extensions.gnome.org/extension/307/dash-to-dock/
	xdg-open https://extensions.gnome.org/extension/4627/focus-changer/
	xdg-open https://extensions.gnome.org/extension/5060/xremap/

	# TODO: add valent extension or gsconnect
	xdg-open https://extensions.gnome.org/extension/1336/run-or-raise/
	xdg-open https://extensions.gnome.org/extension/3956/gnome-fuzzy-app-search/
	xdg-open https://extensions.gnome.org/extension/6072/fullscreen-to-empty-workspace/

	cargo install xremap --features gnome
	grep -E '^input:' /usr/lib/group | sudo tee -a /etc/group
	sudo usermod -aG input $USER
	echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/input.rules

toggle-battery-conservation:
	#!/usr/bin/env bash

	# File path for conservation mode
	FILE="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

	# Check the current value
	CURRENT_VALUE=$(cat $FILE)

	# Toggle the value
	if [ "$CURRENT_VALUE" -eq 0 ]; then
		echo 1 | sudo tee $FILE > /dev/null
		echo "Conservation mode enabled."
	else
		echo 0 | sudo tee $FILE > /dev/null
		echo "Conservation mode disabled."
	fi

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

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	brew bundle

node-setup:
	#!/usr/bin/env bash

	eval "$(fnm env --use-on-cd)"
	fnm install --lts
	corepack enable pnpm

rust-setup:
	#!/usr/bin/env bash

	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	[[ -f "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env" 

	rustup component add \
		clippy \
		rustfmt \
		rust-analyzer

java-setup:
	#!/usr/bin/env bash

	curl -s "https://get.sdkman.io?rcupdate=false" | bash
	[[ -s "$SDKMAN_DIR" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

	sdk install java
	sdk install maven
	sdk install gradle

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
