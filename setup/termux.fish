#!/data/data/com.termux/files/usr/bin/bash

[ -z "$XDG_PROJECTS_DIR" ] && set -gx XDG_PROJECTS_DIR "$HOME/repos"
set backups /storage/emulated/0/main/backup

# packages
set base_packages eza fd git ripgrep termux-api
set extra_packages clang dust python python-pip renameutils zoxide
set python_packages requests yt-dlp "git+https://github.com/nathom/streamrip.git@dev" "git+https://github.com/AminurAlam/streamrip.git"

# urls
set url_font "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFont-Medium.ttf"
set url_dotfiles "https://github.com/AminurAlam/dotfiles.git"
set url_neovim "https://github.com/AminurAlam/neovim.git"
set url_fish_setup "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
set url_mbz "https://github.com/AminurAlam/musicbrainzpy.git"

command mkdir -p $XDG_PROJECTS_DIR $HOME/backup/ $HOME/.local/{share,bin,cache} $HOME/.local/share/zoxide

printf "INSTALLING NEW PACKAGES...\n"
    pacman -Syu --noconfirm --needed $base_packages || exit

printf "DOWNLOADING DOTFILES... "
    [ -d "$path_dots" ] && command rm -fr "$path_dots"
    cd # NOTE: if you are in a deleted directory cloning wont work
    git clone -q --depth 1 "$url_dotfiles" "$path_dots"
    git clone -q --depth 1 "$url_neovim" "$XDG_PROJECTS_DIR/nvim-fork"
    git clone -q --depth 1 "$url_mbz" "$XDG_PROJECTS_DIR/musicbrainzpy"
printf "done\n"

printf "INSTALLING MORE PACKAGES...\n"
pacman -S --needed $extra_packages && begin
    if [ "$(read -P 'install pip packages? [y/N] ')" = y ]
        printf "INSTALLING PYTHON PACKAGES...\n"
        pip install $python_packages
    end
end

printf "LINKING CONFIG DIRECTORIES... "
for config in aria2 clangd fish git htop newsboat npm nvim procs python streamrip tmux yt-dlp zellij
    [ -e "$path_dots/$config" ] || continue
    # unlink/relocate old directories in ~/.config
    [ -d "$HOME/.config/$config" ] && command mv -f ~/.config/$config ~/backup/
    ln -fs "$path_dots/$config" ~/.config/
end
printf "done\n"

printf "LINKING CONFIG FILES... "
    ln -fs "$path_dots/other/clang-format" ~/.clang-format
    ln -fs "$path_dots/other/curlrc" ~/.config/.curlrc
    ln -fs "$path_dots/other/pacman.conf" $PREFIX/etc/pacman.conf
    ln -fs "$path_dots/other/tidal-dl.json" ~/.config/.tidal-dl.json
    ln -fs "$path_dots/other/starship.toml" ~/.config/starship.toml
    ln -fs "$path_dots/other/stylua.toml" ~/.config/stylua.toml
    ln -fs "$path_dots/termux/colors.properties" ~/.termux/colors.properties
    ln -fs "$path_dots/termux/termux.properties" ~/.termux/termux.properties
printf "done\n"

printf "CHANGING FONT... "
    command rm -f ~/.termux/font.ttf
    curl -qso ~/.termux/font.ttf "$url_font" &>/dev/null
printf "done\n"

[ -e "$HOME/.termux_authinfo" ] || begin
    printf "ADDING PASSWORD...\n"
    passwd
end

printf "CLEANUP... "
    truncate -s 0 "$PREFIX"/etc/motd*
    [ -d ~/storage/ ] && for path in ~/storage/*
        [ -L "$path" ] && unlink "$path"
    end
    command rmdir --ignore-fail-on-non-empty --parents ~/backup/** ~/storage
    command rm (fd -d1 'bootstrap-aarch64.zip' $HOME)
printf "done\n"

printf "ADDING ZOXIDE DB... "
    [ -e "$backups/db.zo" ] && command cp -f $backups/db.zo $HOME/.local/share/zoxide
printf "done\n"

# TODO: put scripts in bin
# amogus
# lit
# luvi
# luvit
# rish
# rish_shizuku.dex
# tachi
# java-language-server

: # making sure the script returns 0
