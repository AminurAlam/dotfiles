#!/usr/bin/env bash

sudo=$(command -v sudo)

$sudo apt-add-repository ppa:fish-shell/release-3
$sudo apt-get update
$sudo apt-get install fish

# TODO: change shell

mkdir ~/repos
git clone --depth 1 "https://github.com/AminurAlam/dotfiles" ~/repos/dotfiles
$sudo fish ~/repos/dotfiles/setup/ubuntu.fish
