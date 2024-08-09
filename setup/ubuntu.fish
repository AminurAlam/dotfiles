# set packages clang dust eza libgit2 fd git openssh python python-pip renameutils ripgrep starship lua-language-server termux-api zoxide
set packages eza git fish ninja-build gettext cmake unzip curl
set sudo (command -v sudo || command -v doas)

# urls
set url_font "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFont-Medium.ttf"
set url_dotfiles "https://github.com/AminurAlam/dotfiles.git"
set url_neovim "https://github.com/AminurAlam/neovim.git"

# paths
set main "$HOME/aa"
set path_dots "$HOME/repos/dotfiles" # NOTE: mae sure this is a full path
set path_nvim "$HOME/repos/neovim"

command mkdir -p $main $HOME/repos $HOME/.local/{share,bin,cache}/

if apt show starship &>/dev/null
    set -a packages starship
else
    printf "starship is not packaged run: curl -sS https://starship.rs/install.sh | sh\n"
end

if apt show eza &>/dev/null
    set -a packages eza
else
    $sudo apt update
    $sudo apt install -y gpg
    $sudo mkdir -p /etc/apt/keyrings
    curl -qo- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | $sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | $sudo tee /etc/apt/sources.list.d/gierens.list
    $sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    $sudo apt update
    $sudo apt install -y eza
end

# sudo apt install $packages

printf "DOWNLOADING DOTFILES... "
    [ -d "$path_dots" ] && command rm -fr "$path_dots"
    cd # NOTE: if you are in $path_dots cloning wont work
    git clone -q --depth 1 "$url_dotfiles" "$path_dots"
printf "done\n"

printf "LINKING CONFIG DIRECTORIES... "
for config in aria2 clangd fish git nvim python
    [ -e "$path_dots/$config" ] || continue
    # unlink/relocate old directories in ~/.config
    [ -L "$HOME/.config/$config" ] && command unlink "$HOME/.config/$config"
    [ -d "$HOME/.config/$config" ] && command mv -f ~/.config/$config ~/backup/
    ln -fs "$path_dots/$config" ~/.config/
end
printf "done\n"

printf "LINKING CONFIG FILES... "
    ln -fs "$path_dots/other/clang-format" ~/.clang-format
    ln -fs "$path_dots/other/starship.toml" ~/.config/starship.toml
    ln -fs "$path_dots/other/stylua.toml" ~/.config/stylua.toml
printf "done\n"

# command -vq nvim || begin
#     git clone --depth 1 "https://github.com/AminurAlam/neovim.git" "$path_nvim"
#     cd "$path_nvim"
#     make
#     $sudo make install
# end
