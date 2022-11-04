#!/usr/bin/env sh

apt update && apt upgrade
apt install -y fish && chsh -s fish
fish (curl https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish)
