#!/usr/bin/env bash

bootstrap-pacman() {
    printf "\nBOOTSTRAPPING PACMAN
    https://github.com/termux/termux-packages/releases\n\n"

    mkdir ~/../usr-n/

    printf "checking for bootstrap...\n"
    [ -e "/sdcard/main/bootstrap-arm.zip" ] || return

    printf "extracting bootstrap...\n"
    unzip -q -d ~/../usr-n/ /sdcard/main/bootstrap-arm.zip

    cd ~/../usr-n/
    pwd

    printf "creating symlinks...\n"
    cat ~/../usr-n/SYMLINKS.txt | awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}'

    printf "\nRUN THIS COMMAND IN FAILSAFE MODE
    rm -fr ~/../usr/ && mv ~/../usr-n/ ~/../usr/\n\n"
    exit
}

setup-fish-shell() {
    printf "\nINSTALLING FISH\n\n"
    pacman -Syu fish
    chsh -s fish
    curl -s -o setup.fish "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"

    printf "\nBASE SETUP COMPLETE RUN THIS
    fish setup.fish\n\n"
}

yes | termux-setup-storage &> /dev/null
command -v pacman > /dev/null || bootstrap-pacman
pacman-key --init
pacman-key --populate
setup-fish-shell
