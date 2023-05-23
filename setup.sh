#!/usr/bin/env bash

download-bootstrap() {
    printf "\nDOWNLOAD BOOTSTRAP? [y/N] "
    read choice

    case "$choice" in
        y|Y|yes|Yes|YES) true;;
        *) exit;;
    esac

    printf "downloading bootstrap to:
    bootstrap-${arch}.zip\n"

    curl --progress-bar -LO -- "${root_url}/latest/download/bootstrap-$arch.zip"
}

check-hash() {
    printf "checking hash of cached archive...\n"
    curl -sL -- "${root_url}/latest/download/CHECKSUMS-md5.txt" \
    | awk -F '\t' '{print $2 "  " $1}' \
    | md5sum --status --check --ignore-missing - 2>/dev/null \
    || download-bootstrap
}

bootstrap-pacman() {
    root_url="https://github.com/termux-pacman/termux-packages/releases"

    printf "\nBOOTSTRAPPING PACMAN...
    ${root_url}/\n"

    printf "determining arch...\n"
    case "$(uname -m)" in
        aarch64) arch=aarch64 ;;
        arm*)    arch=arm     ;;
        i686)    arch=i686    ;; # not tested
        x86_64)  arch=x86_64  ;; # not tested
        *)
        printf "$(uname -m) is not a valid arch\n"
        exit ;;
    esac
    printf "arch: $arch\n"

    bootstrap_path="/sdcard/main/termux/bootstrap-${arch}.zip"
    cd /sdcard/main/termux/

    printf "checking for bootstrap...\n"
    [ -e "bootstrap-${arch}.zip" ] && check-hash || download-bootstrap

    mkdir -p ~/../usr-n/
    cd ~/../usr-n/

    printf "extracting bootstrap...\n"
    unzip -q -d ~/../usr-n/ "/sdcard/main/termux/bootstrap-${arch}.zip"

    printf "creating symlinks...\n"
    cat ~/../usr-n/SYMLINKS.txt | awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}'

    cd

    printf "\nRUN THIS COMMAND IN FAILSAFE MODE
    cd .. && rm -fr usr/ && mv usr-n/ usr/\n"

    unset arch

    exit
}

yes | termux-setup-storage &> /dev/null
command -v pacman > /dev/null || bootstrap-pacman

printf "\nGENERATING PACMAN KEYS...\n"
pacman-key --init &> /dev/null
pacman-key --populate &> /dev/null

printf "\nINSTALLING FISH...\n"
pacman -Syu --noconfirm --needed fish
printf "\nCHANGING SHELL...\n"
chsh -s fish

curl -so setup.fish "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
printf "\nBASE SETUP COMPLETE RUN THIS
    fish setup.fish\n"
