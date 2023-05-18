#!/usr/bin/env bash

download-bootstrap() {
    printf "\nDOWNLOAD BOOTSTRAP? [y/N] "
    read choice

    case "$choice" in
        y|Y|yes|Yes|YES) true;;
        *) exit;;
    esac

    printf "downloading bootstrap to:
    $bootstrap_path\n"

    curl --progress-bar -Lo "$bootstrap_path" -- \
    "https://github.com/termux-pacman/termux-packages/releases/latest/download/bootstrap-$arch.zip"
}

bootstrap-pacman() {
    printf "\nBOOTSTRAPPING PACMAN...
    https://github.com/termux-pacman/termux-packages/releases/\n"

    printf "determining arch...\n"
    case "$(uname -m)" in
        aarch64) arch=aarch64 ;;
        arm*)    arch=arm     ;;
        i686)    arch=i686    ;; # not tested
        x86_64)  arch=x86_64  ;; # not tested
        *)
        printf "$(uname -m) is not valid arch\n"
        exit ;;
    esac
    printf "arch: $arch\n"

    printf "checking for bootstrap...\n"
    bootstrap_path="/sdcard/main/termux/bootstrap-${arch}.zip"
    [ -e "${bootstrap_path}" ] && printf "path: ${bootstrap_path}\n" || download-bootstrap

    mkdir -p ~/../usr-n/
    cd ~/../usr-n/

    printf "extracting bootstrap...\n"
    unzip -q -d ~/../usr-n/ "$bootstrap_path"

    printf "creating symlinks...\n"
    cat ~/../usr-n/SYMLINKS.txt | awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}'

    printf "\nRUN THIS COMMAND IN FAILSAFE MODE
    cd .. && rm -fr usr/ && mv usr-n/ usr/\n"

    unset arch
    unset bootstrap_path

    exit
}

yes | termux-setup-storage &> /dev/null
command -v pacman > /dev/null || bootstrap-pacman

printf "\nGENERATING PACMAN KEYS...\n"
pacman-key --init &> /dev/null
pacman-key --populate &> /dev/null

printf "\nINSTALLING FISH...\n"
pacman -Syu --noconfirm --needed fish
printf "CHANGING SHELL...\n"
chsh -s fish

curl -so setup.fish "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
printf "\nBASE SETUP COMPLETE RUN THIS
    fish setup.fish\n"
