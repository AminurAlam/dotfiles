#!/usr/bin/env sh

termux-setup-storage
termux-change-repo
yes | apt update
yes | apt upgrade
apt -y install fish
chsh -s fish
curl -o setup.fish "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
fish setup.fish
