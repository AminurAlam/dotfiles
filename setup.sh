#!/usr/bin/env sh

termux-setup-storage
apt update && apt upgrade && apt install -y fish
curl -o setup.fish "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
fish setup.fish
