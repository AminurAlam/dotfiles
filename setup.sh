#!/usr/bin/env bash

bootstrap-pacman() {
    printf "\nBOOTSTRAPPING PACMAN
    https://github.com/termux/termux-packages/releases\n\n"

    mkdir ~/../usr-n/ 2> /dev/null
    cd ~/../usr-n/

    printf "checking for bootstrap...\n"
    [ -e "/sdcard/main/bootstrap-arm.zip" ] || return

    printf "extracting bootstrap...\n"
    unzip -q -d ~/../usr-n/ /sdcard/main/bootstrap-arm.zip

    printf "creating symlinks...\n"
    cat ~/../usr-n/SYMLINKS.txt | awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}'

    printf "\nRUN THIS COMMAND IN FAILSAFE MODE
    cd .. && rm -fr usr/ && mv usr-n/ usr/\n\n"
    exit
}

yes | termux-setup-storage &> /dev/null
command -v pacman > /dev/null || bootstrap-pacman

printf "GENERATING PACMAN KEYS...\n"
pacman-key --init &> /dev/null
pacman-key --populate &> /dev/null

printf "INSTALLING FISH...\n"
yes | pacman -Syu fish &> /dev/null
chsh -s fish
curl -so setup.fish "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"

printf "BASE SETUP COMPLETE RUN THIS
    fish setup.fish\n"
