#!/usr/bin/env bash

fish_setup_url="https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"

download-bootstrap() {
    printf "%s\n" "$1"

    if [[ "$1" = "outdated" ]]; then
        printf "\ndownload new bootstrap? [y/N] "
        read -r choice

        case "$choice" in
            y|Y|yes|Yes|YES) true;;
            *) return;;
        esac
    fi

    printf "downloading bootstrap to:
    bootstrap-%s.zip\n" "$arch"
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
        printf "%s is not a recognised arch\n" "$(uname -m)"
        exit ;;
    esac
    printf "%s\n" "$arch"

    bootstrap_path="/sdcard/main/termux/bootstrap-%s.zip" $arch
    main="/sdcard/main/termux/"
    cd "$main" || exit

    printf "checking for bootstrap... "
    if [ -e "bootstrap-${arch}.zip" ]; then
        check-hash
    else
        download-bootstrap
    fi

    mkdir -p ~/../usr-n/
    cd ~/../usr-n/ || exit

    printf "extracting bootstrap...\n"
    unzip -q -d ~/../usr-n/ "$main/bootstrap-${arch}.zip"

    printf "creating symlinks...\n"
    awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}' ~/../usr-n/SYMLINKS.txt

    cd || exit

    printf "\nRUN THIS COMMAND IN FAILSAFE MODE
    cd .. && rm -fr usr/ && mv usr-n/ usr/\n"

    exit
}

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

printf "\nBASE SETUP COMPLETE\n"

fish setup.fish
