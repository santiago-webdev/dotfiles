#!/usr/bin/env bash

rm -rf README.md
stow -t ~/ --no-folding * -R
git restore  README.md
