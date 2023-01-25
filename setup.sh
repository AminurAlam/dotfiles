#!/usr/bin/env bash

bootstrap-pacman() {
    printf "\nBOOTSTRAPPING PACMAN\n\n"

    mkdir ~/../usr-n/
    unzip -d ~/../usr-n/ /sdcard/main/bootstrap-arm.zip || return
    cat ~/../usr-n/SYMLINKS.txt | awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}'

    printf "RUN THIS COMMAND IN FAILSAFE MODE
    [ -d ~/../usr-n/ ] && rm -fr ~/../usr/ && mv ~/../usr-n/ ~/../usr/
    "
    exit
}

configure-fish() {
    printf "\nRUNNING FISH CONFIG\n\n"
    fish setup.fish
    chsh -s fish
}

command -v pacman || bootstrap-pacman
pacman-key --init
pacman-key --populate

termux-setup-storage
pacman -S fish
curl -o setup.fish "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"

printf "SETUP COMPLETE"
