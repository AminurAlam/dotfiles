#!/usr/bin/env sh
echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
echo "deb https://packages-cf.termux.dev/apt/termux-x11 x11 main" > $PREFIX/etc/apt/sources.list.d/x11.list
apt update && apt upgrade
apt install -y fish git && chsh -s fish
fish "setup.fish"
