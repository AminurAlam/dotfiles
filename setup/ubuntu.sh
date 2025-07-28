#!/usr/bin/env bash
# shellcheck disable=2015

apt update && apt upgrade
yes '\n' | add-apt-repository ppa:fish-shell/release-4
apt-get update
apt-get install fish git

mkdir ~/repos
git clone --depth 1 "https://github.com/AminurAlam/dotfiles" ~/repos/dotfiles
cd ~/repos/dotfiles/ && git pull

chsh -s "$(command -v fish)"
fish ~/repos/dotfiles/setup/ubuntu.fish
