#!/usr/bin/env bash

termux_setup="https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
boot_url="https://github.com/termux-pacman/termux-packages/releases/latest/download/bootstrap-aarch64.zip"
boot_path="$HOME/bootstrap-aarch64.zip"

bootstrap-pacman() {
    printf "BOOTSTRAPPING PACMAN...\n"

    [ -e "$boot_path" ] || curl --create-dirs -q#Lo "$boot_path" -- "$boot_url"

    mkdir -p ~/../usr-n/
    cd ~/../usr-n/ || exit

    printf "extracting bootstrap... "
    unzip -qd ~/../usr-n/ "$boot_path"
    printf "done\n"

    printf "creating symlinks... "
    awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}' < ~/../usr-n/SYMLINKS.txt
    printf "done\n"

    printf "\nRUN THIS COMMAND IN FAILSAFE MODE
    cd .. && rm -fr usr/ && mv usr-n/ usr/\n"

    exit
}

yes | termux-setup-storage &>/dev/null
command -v pacman &>/dev/null || bootstrap-pacman

printf "GENERATING PACMAN KEYS... "
pacman-key --init &>/dev/null
pacman-key --populate &>/dev/null
printf "done\n"

printf "INSTALLING FISH...\n"
pacman -Syuq --noconfirm --needed -- fish || {
    printf 'failed\n'
    exit
}

printf "CHANGING SHELL... "
chsh -s fish
printf "done\n"

printf "DOWNLAODING setup.fish...\n"
curl -q#O "$termux_setup"

printf "BASE SETUP COMPLETE\n"
printf "RUNNING FISH SETUP...\n"

fish=$(command -v fish)
$fish setup.fish
