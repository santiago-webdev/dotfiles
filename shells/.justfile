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
		app.drey.KeyRack \
		ca.desrt.dconf-editor \
		ca.edestcroix.Recordbox \
		com.github.flxzt.rnote \
		com.github.neithern.g4music \
		com.github.tchx84.Flatseal \
		com.github.wwmm.easyeffects \
		com.usebottles.bottles \
		org.gnome.Boxes \
		org.gnome.World.Secrets \
		org.gnome.seahorse.Application \
		org.localsend.localsend_app \
		org.mozilla.Thunderbird \
		org.mozilla.firefox \
		org.nickvision.tagger \
		org.torproject.torbrowser-launcher \
		org.videolan.VLC \
		re.sonny.Junction

# io.github.nokse22.Exhibit \
# com.github.ADBeveridge.Raider \
# io.github.celluloid_player.Celluloid \
# org.nicotine_plus.Nicotine \
# com.google.Chrome \
# com.microsoft.Edge \
# com.vivaldi.Vivaldi \
# dev.tchx84.Portfolio \
# com.brave.Browser \
# org.beeref.BeeRef \
# org.blender.Blender \
# org.getmonero.Monero \
# org.inkscape.Inkscape \
# org.kde.krita \
# org.keepassxc.KeePassXC \
# org.qbittorrent.qBittorrent \
# com.discordapp.Discord \

gnome-extensions:
	#!/usr/bin/env bash

	xdg-open https://extensions.gnome.org/extension/615/appindicator-support/
	xdg-open https://extensions.gnome.org/extension/3193/blur-my-shell/
	xdg-open https://extensions.gnome.org/extension/307/dash-to-dock/
	xdg-open https://extensions.gnome.org/extension/1319/gsconnect/
	xdg-open https://extensions.gnome.org/extension/2236/night-theme-switcher/
	xdg-open https://extensions.gnome.org/extension/5278/pano/
	xdg-open https://extensions.gnome.org/extension/1336/run-or-raise/
	xdg-open https://extensions.gnome.org/extension/1460/vitals/

	xdg-open https://extensions.gnome.org/extension/4269/alphabetical-app-grid/
	xdg-open https://extensions.gnome.org/extension/5500/auto-activities/
	xdg-open https://extensions.gnome.org/extension/5389/screen-rotate/
	xdg-open https://extensions.gnome.org/extension/3100/maximize-to-empty-workspace/
	xdg-open https://extensions.gnome.org/extension/5724/battery-health-charging/
	xdg-open https://extensions.gnome.org/extension/2645/brightness-control-using-ddcutil/

kanata-setup:
	#!/usr/bin/env bash
	
	cargo install kanata
	grep -E '^input:' /usr/lib/group | sudo tee -a /etc/group
	sudo usermod -aG input $USER
	sudo groupadd uinput
	sudo usermod -aG uinput $USER
	echo 'KERNEL=="uinput", GROUP="uinput", MODE:="0660"' | sudo tee /etc/udev/rules.d/99-uinput.rules
	systemctl --user enable kanata.service

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

hook-paths-server:
	#!/usr/bin/env bash

	sshfs st@192.168.100.164:/home/st/Downloads/torrents ~/Downloads/torrents
	sshfs st@192.168.100.164:/home/st/Music ~/Music

sync-clock:
	sudo systemctl enable --now systemd-timesyncd
	sudo systemctl restart systemd-timesyncd

quadlets:
	#!/usr/bin/env bash

	systemctl --user daemon-reload
	systemctl --user enable --now podman-auto-update.timer
	systemctl --user start syncthing-quadlet

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

bios:
	systemctl reboot --firmware-setup

update:
	rpm-ostree upgrade
	flatpak upgrade
	distrobox upgrade --all

accelerometer-fix:
	#!/usr/bin/env bash

	sudo ausearch -m avc -c "iio-sensor-prox" --raw | audit2allow -M iio-sensor-proxy-exception 
	sudo semodule -i iio-sensor-proxy-exception.pp
	sudo systemctl restart iio-sensor-proxy
