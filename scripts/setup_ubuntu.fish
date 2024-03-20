
set arch (uname -m | sed 's/^arm.*/arm/')
# set packages clang dust eza libgit2 fd git openssh python python-pip renameutils ripgrep starship lua-language-server termux-api zoxide
set packages git fish ninja-build gettext cmake unzip curl

# urls
set url_font "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Regular/SauceCodeProNerdFont-Regular.ttf"
set url_dotfiles "https://github.com/AminurAlam/dotfiles.git"
set url_neovim "https://github.com/AminurAlam/neovim.git"
set url_fish_setup "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
set url_bootstrap "https://github.com/termux-pacman/termux-packages/releases"
# paths
# set main "/sdcard/main/termux/"
set path_dots "$HOME/repos/dotfiles" # NOTE: mae sure this is a full path
set path_nvim "$HOME/repos/neovim"

command mkdir -p $HOME/{backup,repos}/ $HOME/.local/{share,bin,cache}/

sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install $packages

command -vq starship || curl -sS https://starship.rs/install.sh | sh

command -vq nvim || begin
    git clone --depth 1 "https://github.com/AminurAlam/neovim.git" "$path_nvim"
    cd "$path_nvim"
    make
    sudo make install
end
