#!/usr/bin/env bash
# shellcheck disable=2015

sudo=$(command -v sudo)
$sudo apt update && $sudo apt upgrade
command -vq apt-add-repository && {
    $sudo apt-add-repository ppa:fish-shell/release-3
    $sudo apt-get update
    $sudo apt-get install fish git
} || $sudo apt install fish git

# TODO: change shell

mkdir ~/repos
git clone --depth 1 "https://github.com/AminurAlam/dotfiles" ~/repos/dotfiles
$sudo fish ~/repos/dotfiles/setup/ubuntu.fish
