#!/usr/bin/env bash

fish_setup_url="https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"

download-bootstrap() {
    printf "$1\n"

    if [[ "$1" = "outdated" ]]; then
        printf "\ndownload new bootstrap? [y/N] "
        read choice

        case "$choice" in
            y|Y|yes|Yes|YES) true;;
            *) return;;
        esac
    fi

    printf "downloading bootstrap to:
    bootstrap-${arch}.zip\n"
    curl -#LO -- "${root_url}/latest/download/bootstrap-$arch.zip"
}

check-hash() {
    printf "present\n"
    printf "checking hash of cached archive...\n"
    curl -sL -- "${root_url}/latest/download/CHECKSUMS-md5.txt" \
    | awk -F '\t' '{print $2 "  " $1}' \
    | md5sum --status --check --ignore-missing - 2>/dev/null \
    || download-bootstrap "outdated"
}

bootstrap-pacman() {
    root_url="https://github.com/termux-pacman/termux-packages/releases"

    printf "\nBOOTSTRAPPING PACMAN...\n"

    printf "determining arch... "
    case "$(uname -m)" in
        aarch64) arch=aarch64 ;;
        arm*)    arch=arm     ;;
        i686)    arch=i686    ;; # not tested
        x86_64)  arch=x86_64  ;; # not tested
        *)
        printf "$(uname -m) is not a recognised arch\n"
        exit ;;
    esac
    printf "$arch\n"

    bootstrap_path="/sdcard/main/termux/bootstrap-${arch}.zip"
    main="/sdcard/main/termux/"
    cd "$main"

    printf "checking for bootstrap... "
    [ -e "bootstrap-${arch}.zip" ] && check-hash || download-bootstrap

    mkdir -p ~/../usr-n/
    cd ~/../usr-n/

    printf "extracting bootstrap...\n"
    unzip -q -d ~/../usr-n/ "$main/bootstrap-${arch}.zip"

    printf "creating symlinks...\n"
    cat ~/../usr-n/SYMLINKS.txt | awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}'

    cd

    printf "\nRUN THIS COMMAND IN FAILSAFE MODE
    cd .. && rm -fr usr/ && mv usr-n/ usr/\n"

    exit
}

# TODO: move everything to fish

yes | termux-setup-storage &>/dev/null
command -v pacman >/dev/null || bootstrap-pacman

printf "\nGENERATING PACMAN KEYS... "
    pacman-key --init &>/dev/null
    pacman-key --populate &>/dev/null
printf "done\n"

printf "INSTALLING FISH... "
    pacman -Syuq --noconfirm --needed -- fish 1>/dev/null
printf "done\n"

printf "CHANGING SHELL... "
    chsh -s fish
printf "done\n"

printf "DOWNLAODING setup.fish..."
    curl -#O "$fish_setup_url"

printf "\nBASE SETUP COMPLETE RUN THIS
    fish setup.fish\n"
