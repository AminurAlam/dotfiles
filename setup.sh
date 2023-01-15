#!/usr/bin/env bash

bootstrap-pacman() {
    printf 'BOOTSTRAPPING PACMAN'

    mkdir ~/../usr-n/
    unzip -d ~/../usr-n/ /sdcard/main/bootstrap-arm.zip
    cat ~/../usr-n/SYMLINKS.txt | awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}'

    printf 'RUN THESE COMMANDS IN FAILSAFE MODE
    rm -fr ~/../usr/
    mv ~/../usr-n/ ~/../usr/
    '
}

configure-fish() {
    printf "RUNNING FISH CONFIG"
    fish setup.fish
    chsh -s fish
}

command -v pacman || bootstrap-pacman
termux-setup-storage
pacman -S fish
curl -o setup.fish "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"

printf "SETUP COMPLETE"
