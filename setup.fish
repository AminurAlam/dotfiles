#!/usr/bin/env fish

[ -n "$XDG_PROJECTS_DIR" ] || set XDG_PROJECTS_DIR "$HOME/repos"

# packages
set base_packages clang dust eza libgit2 fd git openssh python python-pip renameutils ripgrep starship lua-language-server termux-api zoxide
set python_packages requests "git+https://github.com/nathom/streamrip.git@dev" yt-dlp "$XDG_PROJECTS_DIR/deflacue" # TODO: "$XDG_PROJECTS_DIR/musicbrainzpy"

# urls
set url_font "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFont-Medium.ttf"
set url_dotfiles "https://github.com/AminurAlam/dotfiles.git"
set url_neovim "https://github.com/AminurAlam/neovim.git"
set url_fish_setup "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
set url_bootstrap "https://github.com/termux-pacman/termux-packages/releases"

# paths
set main "/sdcard/main/termux/"
set path_dots "$XDG_PROJECTS_DIR/dotfiles" # NOTE: make sure this is a full path
set path_nvim "$XDG_PROJECTS_DIR/nvim-fork"

command mkdir -p $XDG_PROJECTS_DIR $HOME/{backup,repos}/ $HOME/.local/{share,bin,cache}/ $HOME/.local/share/zoxide/

printf "INSTALLING NEW PACKAGES...\n"
    pacman -Syu --noconfirm --needed $base_packages || exit

printf "INSTALLING PYTHON PACKAGES...\n"
    git clone -q --depth 1 "https://github.com/AminurAlam/deflacue" "$XDG_PROJECTS_DIR/deflacue"
    git clone -q --depth 1 "https://github.com/AminurAlam/musicbrainzpy" "$XDG_PROJECTS_DIR/musicbrainzpy"
    pip install $python_packages

printf "DOWNLOADING DOTFILES... "
    [ -d "$path_dots" ] && command rm -fr "$path_dots"
    cd # NOTE: if you are in $path_dots cloning wont work
    git clone -q --depth 1 "$url_dotfiles" "$path_dots"
    git clone -q --depth 1 "$url_neovim" "$path_nvim"
printf "done\n"

printf "LINKING CONFIG DIRECTORIES... "
for config in aria2 clangd fish git htop newsboat npm nvim python streamrip yt-dlp zellij
    [ -e "$path_dots/$config" ] || continue
    # unlink/relocate old directories in ~/.config
    [ -L "$HOME/.config/$config" ] && command unlink "$HOME/.config/$config"
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

# printf "ADDING ZOXIDE DB... "
#     [ -e "$main/db.zo" ] && command cp -f $main/db.zo $HOME/.local/share/zoxide/db.zo
# printf "done\n"

# TODO: copy newsboat db
# printf "ADDING NEWSBOAT DB... "
#     [ -e "$main/db.zo" ] && command cp -f $main/db.zo $HOME/.local/share/zoxide/db.zo
# printf "done\n"

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
