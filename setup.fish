set arch (uname -m | sed 's/^arm.*/arm/')
set packages clang dust eza libgit2 fd git openssh python python-pip renameutils ripgrep starship lua-language-server termux-api zoxide
# urls
set url_font "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Regular/SauceCodeProNerdFont-Regular.ttf"
set url_dotfiles "https://github.com/AminurAlam/dotfiles.git"
set url_neovim "https://github.com/AminurAlam/neovim.git"
set url_fish_setup "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
set url_bootstrap "https://github.com/termux-pacman/termux-packages/releases"
# paths
set main "/sdcard/main/termux/"
set path_dots "$HOME/repos/dotfiles" # NOTE: mae sure this is a full path
set path_nvim "$HOME/repos/nvim-fork"

command mkdir -p $HOME/{backup,repos}/ $HOME/.local/{share,bin,cache}/

printf "INSTALLING NEW PACKAGES...\n"
pacman -Syu --noconfirm --needed $packages || begin
    printf "failed, try installing manually:
    $(set_color $fish_color_command)pacman $(set_color $fish_color_option)-Syu --needed $(set_color $fish_color_param)$packages $(set_color normal)\n"
    exit
end

if command -vq python && command -vq pip
    printf "INSTALLING PYTHON PACKAGES\n"
    pip install requests deflacue
end

printf "DOWNLOADING DOTFILES... "
    [ -d "$path_dots" ] && command rm -fr "$path_dots"
    cd # NOTE: if you are in $path_dots cloning wont work
    git clone -q --depth 1 "$url_dotfiles" "$path_dots"
    git clone -q --depth 1 "$url_neovim" "$path_nvim"
printf "done\n"

printf "LINKING CONFIG DIRECTORIES... "
for config in aria2 clangd fish git htop newsboat npm nvim python yt-dlp
    [ -e "$path_dots/$config" ] || continue
    # unlink/move old directories in ~/.config to be replaced
    [ -L "$HOME/.config/$config" ] && command unlink "$HOME/.config/$config"
    [ -d "$HOME/.config/$config" ] && command mv -f ~/.config/$config ~/backup/
    ln -fs "$path_dots/$config" ~/.config/
end
printf "done\n"

printf "LINKING CONFIG FILES... "
    ln -fs "$path_dots/other/pacman.conf" $PREFIX/etc/pacman.conf
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

# if [ -e "$main/bin.sha256" ]
#     sha256sum --check $main/bin.sha256 2>/dev/null | awk -F / '{print "  "$9}'
# else
#     printf "bin.sha256 is missing\n"
# end

# TODO: move completely to fish
# TODO: copy newsboat db
# TODO: ~/repos/ -> ~/projects/

: # make sure the script returns 0
