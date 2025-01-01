#!/data/data/com.termux/files/usr/bin/fish

# packages
set base_packages eza fd git ripgrep termux-api termux-auth
set extra_packages clang dust python python-pip python-ensurepip-wheels python-yt-dlp renameutils zoxide
set python_packages "git+https://github.com/nathom/streamrip.git@dev" "git+https://github.com/AminurAlam/deflacue.git" "https://files.pythonhosted.org/packages/a1/fc/011727826f98417968f81a6f0c45722aceb2dcf9512f7cb691687733f304/dr14-t.meter-1.0.16.tar.gz"
set dir_configs alacritty aria2 clangd eza fish gdb git htop lazygit newsboat npm nvim procs python ruff streamrip termux tmux yazi yt-dlp zellij

# urls
set url_font "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFont-Medium.ttf"
set url_dotfiles "https://github.com/AminurAlam/dotfiles.git"
set url_neovim "https://github.com/AminurAlam/neovim.git"
set url_fish_setup "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
set url_mbz "https://github.com/AminurAlam/musicbrainzpy.git"

# paths
[ -z "$XDG_PROJECTS_DIR" ] && set -gx XDG_PROJECTS_DIR "$HOME/repos"
set dots "$XDG_PROJECTS_DIR/dotfiles" # NOTE: make sure this is a full path



command mkdir -p $XDG_PROJECTS_DIR $HOME/backup/ $HOME/.local/{share,bin,cache} $HOME/.local/share/zoxide

printf "INSTALLING NEW PACKAGES...\n"
    pacman -Syu --noconfirm --needed $base_packages || exit

printf "DOWNLOADING DOTFILES... "
    if [ -d "$dots" ]
        pushd "$dots"
        git pull -q origin
        popd
    else
        git clone -q --depth 1 "$url_dotfiles" "$dots"
    end
printf "done\n"

printf "INSTALLING MORE PACKAGES...\n"
pacman -S --needed $extra_packages && begin
    if [ "$(read -P 'install pip packages? [y/N] ')" = y ]
        printf "INSTALLING PYTHON PACKAGES...\n"
        env CFLAGS="-Wno-incompatible-function-pointer-types -Wno-implicit-function-declaration" pip install pycares
        pip install $python_packages
        [ -e $dots/scripts/patches/yt-dlp-YoutubeDL.py.diff ]
        and patch $PREFIX/lib/python3.12/site-packages/yt_dlp/YoutubeDL.py <$dots/scripts/patches/yt-dlp-YoutubeDL.py.diff
    end
end

printf "LINKING CONFIG DIRECTORIES... "
for config in $dir_configs
    [ -e "$dots/$config" ] || continue
    # unlink/relocate old directories in ~/.config
    [ -L "$HOME/.config/$config" ] && command unlink ~/.config/$config
    [ -d "$HOME/.config/$config" ] && command mv -f ~/.config/$config ~/backup/
    ln -fs "$dots/$config" ~/.config/
end
printf "done\n"

printf "LINKING CONFIG FILES... "
    ln -fs "$dots/other/clang-format" ~/.clang-format
    ln -fs "$dots/other/curlrc" ~/.config/.curlrc
    ln -fs "$dots/other/pacman.conf" $PREFIX/etc/pacman.conf
    ln -fs "$dots/other/tidal-dl.json" ~/.config/.tidal-dl.json
    ln -fs "$dots/other/starship.toml" ~/.config/starship.toml
    ln -fs "$dots/other/stylua.toml" ~/.config/stylua.toml
    ln -fs "$dots/other/taplo.toml" ~/.config/taplo.toml
    ln -fs "$dots/termux/colors.properties" ~/.termux/colors.properties # https://github.com/termux/termux-app/blob/master/termux-shared/src/main/java/com/termux/shared/termux/TermuxConstants.java#L657
    ln -fs "$dots/termux/termux.properties" ~/.termux/termux.properties
printf "done\n"

printf "CHANGING FONT... "
    command rm -f ~/.termux/font.ttf
    curl -Lqs -o ~/.termux/font.ttf "$url_font" &>/dev/null
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
    set needs_cleaning ~/backup/** ~/storage
    command rmdir --ignore-fail-on-non-empty --parents $needs_cleaning &>/dev/null
    command rm -f "$HOME/bootstrap-aarch64.zip"
printf "done\n"

# TODO: put scripts in bin

: # making sure the script returns 0
