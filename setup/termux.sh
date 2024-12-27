#!/data/data/com.termux/files/usr/bin/bash

setup_url="https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup/termux.fish"
boot_url="https://github.com/termux-pacman/termux-packages/releases/latest/download/bootstrap-aarch64.zip"
boot_path="$HOME/bootstrap-aarch64.zip"

bootstrap-pacman() {
    printf "BOOTSTRAPPING PACMAN...\n"

    printf "downloading bootstrap...\n"
    [ -e "$boot_path" ] || curl --create-dirs -#Lq -o "$boot_path" -- "$boot_url"

    mkdir -p ~/../usr-n/
    cd ~/../usr-n/ || exit

    printf "extracting bootstrap... "
    unzip -qd ~/../usr-n/ "$boot_path"
    printf "done\n"

    printf "creating symlinks... "
    awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}' <~/../usr-n/SYMLINKS.txt
    printf "done\n"

    printf "\nRUN THIS COMMAND IN FAILSAFE MODE
    cd .. && rm -fr usr/ && mv usr-n/ usr/\n"

    exit
}

printf "PROMPTING FOR STORAGE PERMISSION... "
    yes | termux-setup-storage &>/dev/null
printf "done\n"

command -v pacman &>/dev/null || bootstrap-pacman

printf "INSTALLING FISH...\n"
    pacman -Syuq --noconfirm --needed -- fish || exit

printf "CHANGING SHELL... "
    chsh -s fish
printf "done\n"

printf "RUNNING FISH SETUP...\n"
    curl -#Lq -o "$HOME/termux.fish" "$setup_url"
    fish=$(command -v fish)
    $fish "$HOME/termux.fish"
