#!/usr/bin/env bash

termux_setup="https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
root_url="https://github.com/termux-pacman/termux-packages/releases"

bootstrap-pacman() {
    printf "BOOTSTRAPPING PACMAN...\n"
    printf "determining arch... "
    arch="$(uname -m | sed 's/^arm.*/arm/')"
    printf "%s\n" "$arch"

    bootstrap_path="$HOME/bootstrap-${arch}.zip"

    printf "downloading bootstrap...\n"
    [ -e "$bootstrap_path" ] || curl --create-dirs -q#Lo "$bootstrap_path" -- "${root_url}/latest/download/bootstrap-${arch}.zip"

    mkdir -p ~/../usr-n/
    cd ~/../usr-n/ || exit

    printf "extracting bootstrap... "
    unzip -qd ~/../usr-n/ "$bootstrap_path"
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
