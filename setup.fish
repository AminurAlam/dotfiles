set arch (uname -m | sed 's/^arm.*/arm/')
set dotfiles $HOME/repos/dotfiles # NOTE: make sure this is a full path
set main /sdcard/main/termux
set packages dust libgit2 fd git neovim openssh renameutils ripgrep starship lua-language-server termux-api zoxide
set font_url "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Regular/SauceCodeProNerdFont-Regular.ttf"
set dotfiles_url "https://github.com/AminurAlam/dotfiles.git"
set fish_setup_url "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
set root_url "https://github.com/termux-pacman/termux-packages/releases"
set main "/sdcard/main/termux/"

command mkdir -p $HOME/{backup,repos,.shortcuts}/ $HOME/.local/{share,bin,cache}/

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
    # curl -q#LO -- "${root_url}/latest/download/bootstrap-$arch.zip"
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

function setup-vnc
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
    [ -d "$dotfiles" ] && command rm -fr "$dotfiles"
    cd # NOTE: if you are in $dotfiles cloning wont work
    git clone -q --depth 1 "$dotfiles_url" "$dotfiles"
printf "done\n"

printf "LINKING CONFIG DIRECTORIES... "
for config in aria2 fish git mutt newsboat npm nvim python
    [ -e "$dotfiles/$config" ] || continue
    # unlink/move old directories in ~/.config to be replaced
    [ -L "$HOME/.config/$config" ] && command unlink "$HOME/.config/$config"
    [ -d "$HOME/.config/$config" ] && command mv -f ~/.config/$config ~/backup/
    ln -fs "$dotfiles/$config" ~/.config/
end
printf "done\n"

printf "LINKING CONFIG FILES... "
    ln -fs "$dotfiles/other/curlrc" ~/.config/.curlrc
    ln -fs "$dotfiles/other/stylua.toml" ~/.config/stylua.toml
    ln -fs "$dotfiles/other/starship.toml" ~/.config/starship.toml
    ln -fs "$dotfiles/termux/colors.properties" ~/.termux/colors.properties
    ln -fs "$dotfiles/termux/termux.properties" ~/.termux/termux.properties
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

printf "CLEANUP... "
    truncate -s 0 "$PREFIX"/etc/motd*
    [ -d ~/storage/ ] && command rm -fr ~/storage/
    command rmdir --ignore-fail-on-non-empty ~/backup/
echo "done\n"

[ -e "$HOME/.termux_authinfo" ] || passwd
[ "$(read -P 'downlad font? [y/N] ')" = y ] && curl -qso ~/.termux/font.ttf "$font_url" &>/dev/null

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

# TODO: proot-distro and gui
# TODO: zoxide db merge
# TODO: better integrity check
# TODO: move completely te fish

: # make sure the script returns 0
