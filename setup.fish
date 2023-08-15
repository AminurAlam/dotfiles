set arch (uname -m | sed 's/^arm.*/arm/')
set packages dust libgit2 fd git neovim openssh renameutils ripgrep starship lua-language-server termux-api zoxide
# urls
set url_font "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Regular/SauceCodeProNerdFont-Regular.ttf"
set url_dotfiles "https://github.com/AminurAlam/dotfiles.git"
set url_neovim "https://github.com/AminurAlam/neovim.git"
set url_fish_setup "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
set url_bootstrap "https://github.com/termux-pacman/termux-pacages/releases"
# paths
set main "/sdcard/main/termux/"
set path_dots "$HOME/repos/dotfiles" # NOTE: mae sure this is a full path
set path_nvim "$HOME/repos/nvim-fork"

command mkdir -p $HOME/{backup,repos}/ $HOME/.local/{share,bin,cache}/

function download-bootstrap
    # printf "%s\n" "$1"
    #
    # if [[ "$1" = "outdated" ]]; then
    #     printf "\ndownload new bootstrap? [y/N] "
    #     read -r choice
    #
    #     case "$choice" in
    #         y|Y|yes|Yes|YES) true;;
    #         *) return;;
    #     esac
    # fi
    #
    # printf "downloading bootstrap to: bootstrap-%s.zip\n" "$arch"
    # curl -q#LO -- "${url_bootstrap}/latest/download/bootstrap-$arch.zip"
end

function check-hash
    # printf "present\n"
    # printf "checking hash of cached archive...\n"
    # curl -qsL -- "https://github.com/termux-pacman/termux-packages/releases/latest/download/CHECKSUMS-md5.txt" \
    # | awk -F '\t' " /$arch/ {print \$2 \"  \" \$1}" \
    # | md5sum --status --check \
    # || download-bootstrap "outdated"
end

function bootstrap-pacman
    # printf "BOOTSTRAPPING PACMAN...\n"
    # printf "determining arch... "
    # switch (uname -m)
    #     case aarch64; set arch aarch64
    #     case "arm*";  set arch arm
    #     case "*"
    #         printf "%s is not a recognised arch\n" "$(uname -m)"
    #         exit
    # end
    # printf "%s\n" "$arch"
    #
    # set bootstrap_path "$main/bootstrap-$arch.zip"
    # cd "$main" || exit
    #
    # printf "looking for bootstrap... "
    # if [ -e "bootstrap-$arch.zip" ]
    #     check-hash
    # else
    #     download-bootstrap
    # end
    #
    # mkdir -p ~/../usr-n/
    # cd ~/../usr-n/ || exit
    #
    # printf "extracting bootstrap...\n"
    # unzip -q -d ~/../usr-n/ "$main/bootstrap-${arch}.zip"
    #
    # printf "creating symlinks...\n"
    # awk -F "←" '{system("ln -s '"'"'"$1"'"'"' '"'"'"$2"'"'"'")}' < ~/../usr-n/SYMLINKS.txt
    #
    # cd
    #
    # printf "\nRUN THIS COMMAND IN FAILSAFE MODE
    # cd .. && rm -fr usr/ && mv usr-n/ usr/\n"
    #
    # exit
end

# yes | termux-setup-storage &>/dev/null
# command -vq pacman || bootstrap-pacman
# printf "\nGENERATING PACMAN KEYS... "
#     pacman-key --init &>/dev/null
#     pacman-key --populate &>/dev/null
# printf "done\n"

function setup-proot
    :
end

function setup-x11
    :
end

printf "INSTALLING NEW PACKAGES...\n"
pacman -Syu --noconfirm --needed $packages || begin
    printf "failed, try installing manually:
    $(set_color $fish_color_command)pacman $(set_color $fish_color_option)-Syu --needed $(set_color $fish_color_param)$packages $(set_color normal)\n"
    exit
end

if not command -vq python
    printf "INSTALLING PYTHON... "
    pacman -S --needed python >/dev/null
end

if command -vq python && not command -vq pip
    printf "INSTALLING PIP & CLANG "
    pacman -S --needed python-pip >/dev/null
end

if command -vq python && command -vq pip
    printf "INSTALLING REQUESTS & DEFLACUE "
    pip install requests deflacue
end

printf "DOWNLOADING DOTFILES... "
    [ -d "$path_dots" ] && command rm -fr "$path_dots"
    cd # NOTE: if you are in $path_dots cloning wont work
    git clone -q --depth 1 "$url_dotfiles" "$path_dots"
    git clone -q --depth 1 "$url_neovim" "$path_nvim"
printf "done\n"

printf "LINKING CONFIG DIRECTORIES... "
for config in aria2 fish git htop newsboat npm nvim python yt-dlp
    [ -e "$path_dots/$config" ] || continue
    # unlink/move old directories in ~/.config to be replaced
    [ -L "$HOME/.config/$config" ] && command unlink "$HOME/.config/$config"
    [ -d "$HOME/.config/$config" ] && command mv -f ~/.config/$config ~/backup/
    ln -fs "$path_dots/$config" ~/.config/
end
printf "done\n"

printf "LINKING CONFIG FILES... "
    ln -fs "$path_dots/other/curlrc" ~/.config/.curlrc
    ln -fs "$path_dots/other/stylua.toml" ~/.config/stylua.toml
    ln -fs "$path_dots/other/starship.toml" ~/.config/starship.toml
    ln -fs "$path_dots/termux/colors.properties" ~/.termux/colors.properties
    ln -fs "$path_dots/termux/termux.properties" ~/.termux/termux.properties
printf "done\n"

printf "ADDING BINARIES... "
if [ -d "$main/bin/universal/" -a -d "$main/bin/$arch/" ]
    command cp -fr $main/bin/universal/* ~/.local/bin/
    command cp -fr "$main/bin/$arch/"* ~/.local/bin/
    chmod +x ~/.local/bin/*
    printf "done\n"
else
    printf "\$main/bin/universal/ or \$main/bin/$arch/ doesnt exist\n"
end

printf "CHANGING FONT... "
    command rm -f ~/.termux/font.ttf
    curl -qso ~/.termux/font.ttf "$url_font" &>/dev/null
printf "done\n"

printf "ADDING ZOXIDE DB... "
    [ -e "$main/db.zo" ] && command cp -f $main/db.zo $HOME/.local/share/zoxide/db.zo
printf "done\n"

printf "ADDING PASSWORD..."
[ -e "$HOME/.termux_authinfo" ] && echo "done\n" || passwd

printf "CLEANUP... "
    truncate -s 0 "$PREFIX"/etc/motd*
    [ -d ~/storage/ ] && command rm -fr ~/storage/
    command rmdir --ignore-fail-on-non-empty --parents ~/backup/**/
echo "done\n"

# printf "ADDING WIDGETS... "
# if [ -d "$main/widget/" ]
#     command cp -fr $main/widget/* ~/.shortcuts/
#     chmod +x ~/.shortcuts/*
#     printf "done\n"
# else
#     printf "\$main/widgets/ doesnt exist\n"
# end

# if [ -e "$main/bin.sha256" ]
#     sha256sum --check $main/bin.sha256 2>/dev/null | awk -F / '{print "  "$9}'
# else
#     printf "bin.sha256 is missing\n"
# end

# TODO: proot-distro and gui installation
# TODO: move completely to fish
# TODO: copy newsboat db

: # make sure the script returns 0
