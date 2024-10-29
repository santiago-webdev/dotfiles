flatpaks:
	#!/usr/bin/env bash
	
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

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
		org.gnome.Weather \
		org.gnome.baobab \
		org.gnome.clocks \
		org.gnome.font-viewer

	flatpak uninstall --delete-data -y \
		org.gnome.TextEditor

	flatpak install flathub -y \
		app.drey.EarTag \
		ca.desrt.dconf-editor \
		ca.edestcroix.Recordbox \
		com.brave.Browser \
		com.discordapp.Discord \
		com.github.ADBeveridge.Raider \
		com.github.flxzt.rnote \
		com.github.tchx84.Flatseal \
		com.github.wwmm.easyeffects \
		com.google.Chrome \
		com.microsoft.Edge \
		com.toolstack.Folio \
		com.usebottles.bottles \
		com.vivaldi.Vivaldi \
		io.github.celluloid_player.Celluloid \
		io.github.nokse22.Exhibit \
		org.beeref.BeeRef \
		org.blender.Blender \
		org.getmonero.Monero \
		org.gnome.Boxes \
		org.inkscape.Inkscape \
		org.kde.krita \
		org.keepassxc.KeePassXC \
		org.localsend.localsend_app \
		org.mozilla.Thunderbird \
		org.nickvision.tagger \
		org.nicotine_plus.Nicotine \
		org.qbittorrent.qBittorrent \
		org.torproject.torbrowser-launcher \
		org.videolan.VLC \
		re.sonny.Junction

gnome-extensions:
	#!/usr/bin/env bash

	# TODO: add valent extension or gsconnect
	xdg-open https://extensions.gnome.org/extension/1336/run-or-raise/
	xdg-open https://extensions.gnome.org/extension/1460/vitals/
	xdg-open https://extensions.gnome.org/extension/4269/alphabetical-app-grid/
	xdg-open https://extensions.gnome.org/extension/5278/pano/
	xdg-open https://extensions.gnome.org/extension/5500/auto-activities/
	xdg-open https://extensions.gnome.org/extension/5724/battery-health-charging/
	xdg-open https://extensions.gnome.org/extension/6072/fullscreen-to-empty-workspace/
	xdg-open https://extensions.gnome.org/extension/615/appindicator-support/
	xdg-open https://extensions.gnome.org/extension/6325/control-monitor-brightness-and-volume-with-ddcutil/
	xdg-open https://extensions.gnome.org/extension/1319/gsconnect/
	xdg-open https://extensions.gnome.org/extension/2236/night-theme-switcher/
	xdg-open https://extensions.gnome.org/extension/3193/blur-my-shell/
	xdg-open https://extensions.gnome.org/extension/307/dash-to-dock/

kanata-setup:
	#!/usr/bin/env bash
	
	cargo install kanata
	# # TODO
	# # add the service creation
	grep -E '^input:' /usr/lib/group | sudo tee -a /etc/group
	sudo usermod -aG input $USER

	sudo groupadd uinput
	sudo usermod -aG uinput $USER
	# TODO fix this doesn't work
	sudo echo 'KERNEL=="uinput", GROUP="uinput", MODE:="0660"' > /etc/udev/rules.d/99-uinput.rules
	systemctl --user enable kanata.service
	# systemctl --user enable --now kanata.service
	# TODO, we still need to reboot for groups to be aplied

	# user-groups:
	# #!/usr/bin/env bash
	#
	# # echo 'Adding the current user to the "docker" group'
	# # grep -E '^docker:' /usr/lib/group | sudo tee -a /etc/group
	# # sudo usermod -aG docker $USER
	#
	# echo 'Adding the current user to the "input" group'
	# grep -E '^input:' /usr/lib/group | sudo tee -a /etc/group
	# sudo usermod -aG input $USER

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

flatpak-kinoite:
	#!/usr/bin/env bash

	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	flatpak install flathub -y \
		com.discordapp.Discord \
		net.mkiol.SpeechNote \
		org.getmonero.Monero \
		org.kde.kid3 \
		org.kde.krename \
		org.keepassxc.KeePassXC \
		org.mozilla.Thunderbird \
		org.nicotine_plus.Nicotine \
		org.qbittorrent.qBittorrent \
		org.strawberrymusicplayer.strawberry \
		org.torproject.torbrowser-launcher \
		org.videolan.VLC

	flatpak uninstall --delete-data -y \
		org.kde.kmahjongg \
		org.kde.kmines

plasma-extensions:
	#!/user/bin/env bash

	git clone --depth=1 https://github.com/anametologin/krohnkite
	cd krohnkite
	make install

	xdg-open https://github.com/ishovkun/kde-run-or-raise

sync-clock:
	sudo systemctl enable --now systemd-timesyncd
	sudo systemctl restart systemd-timesyncd

quadlets:
	#!/usr/bin/env bash

	systemctl --user daemon-reload
	systemctl --user enable --now podman-auto-update.timer
	systemctl --user start syncthing-quadlet

stow-dotfiles:
	#!/usr/bin/env bash

	cd ~/Documents/Repositories/dotfiles
	./.dotfiles.sh

brew-setup:
	#!/usr/bin/env bash

	source ~/.profile
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	brew bundle

node-setup:
	#!/usr/bin/env bash

	source ~/.profile
	eval "$(fnm env --use-on-cd)"
	fnm install --lts
	corepack enable pnpm

rust-setup:
	#!/usr/bin/env bash

	source ~/.profile
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	[[ -f "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env" 

	rustup component add \
		clippy \
		rustfmt \
		rust-analyzer

java-setup:
	#!/usr/bin/env bash

	source ~/.profile
	curl -s "https://get.sdkman.io?rcupdate=false" | bash
	[[ -s "$SDKMAN_DIR" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

	sdk install java
	sdk install maven
	sdk install gradle

distroboxes:
	distrobox assemble create

waydroid-init:
	#!/usr/bin/env bash

	# sudo waydroid init -f -s VANILLA -v=https://ota.waydro.id/vendor -c=https://ota.waydro.id/system
	wget -q https://f-droid.org/F-Droid.apk.asc
	wget -q https://f-droid.org/F-Droid.apk
	# load the public key
	gpg --keyserver keyserver.ubuntu.com --recv-key 37D2C98789D8311948394E3E41E7044E1DBA2E89
	# verify the file
	gpg --verify F-Droid.apk.asc F-Droid.apk
	waydroid app install F-Droid.apk

bios:
	systemctl reboot --firmware-setup

update:
	rpm-ostree upgrade
	flatpak upgrade
	distrobox upgrade --all
