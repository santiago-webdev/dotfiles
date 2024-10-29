#!/usr/bin/env bash

stow -t ~/ --no-folding -R ansible
# stow -t ~/ --no-folding -R atom-atic # Build fails for some reason with symlinks
stow -t ~/ --no-folding -R autostart
stow -t ~/ --no-folding -R chromium
stow -t ~/ --no-folding -R git
stow -t ~/ --no-folding -R kanata
stow -t ~/ --no-folding -R npm
stow -t ~/ --no-folding -R nushell
stow -t ~/ --no-folding -R nvim
stow -t ~/ --no-folding -R quadlets
stow -t ~/ --no-folding -R scripts
stow -t ~/ --no-folding -R shells
stow -t ~/ --no-folding -R tmux
stow -t ~/ --no-folding -R wireplumber
stow -t ~/ --no-folding -R zellij
