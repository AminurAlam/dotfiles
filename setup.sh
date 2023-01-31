#!/usr/bin/env bash

bootstrap-pacman() {
    printf "BOOTSTRAPPING PACMAN
    https://github.com/termux/termux-packages/releases\r\n"

    mkdir ~/../usr-n/
    unzip -d ~/../usr-n/ /sdcard/main/bootstrap-arm.zip || return
    cat ~/../usr-n/SYMLINKS.txt | awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}'

    printf "RUN THIS COMMAND IN FAILSAFE MODE
    [ -d ~/../usr-n/ ] && rm -fr ~/../usr/ && mv ~/../usr-n/ ~/../usr/\r\n"
    exit
}

setup-fish-shell() {
    pacman -S fish
    chsh -s fish
    curl -o setup.fish "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"

    printf "BASE SETUP COMPLETE RUN THIS
    fish setup.fish\r\n"
}

command -v pacman > /dev/null || bootstrap-pacman
pacman-key --init
pacman-key --populate

termux-setup-storage
setup-fish-shell
