# set packages clang dust eza libgit2 fd git openssh python python-pip renameutils ripgrep starship lua-language-server termux-api zoxide
set packages eza git fish curl

# urls
set url_font "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFont-Medium.ttf"
set url_dotfiles "https://github.com/AminurAlam/dotfiles.git"

# paths
set path_dots "$HOME/repos/dotfiles" # NOTE: mae sure this is a full path
set path_nvim "$HOME/repos/neovim"

command mkdir -p $HOME/repos $HOME/.local/{share,bin,cache}/

if apt show starship &>/dev/null
    set -a packages starship
else
    printf "install starship? [y/N] "
    curl -sS https://starship.rs/install.sh | sh >/dev/null
end

if not apt show eza &>/dev/null
    apt update
    apt install -y gpg
    mkdir -p /etc/apt/keyrings
    curl -Lq -o - https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | tee /etc/apt/sources.list.d/gierens.list
    chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
end

apt update
sudo apt install $packages

printf "DOWNLOADING DOTFILES... "
    [ -d "$path_dots" ] && command rm -fr "$path_dots"
    git clone -q --depth 1 "$url_dotfiles" "$path_dots"
printf "done\n"

printf "CHANGING FONT... "
    curl -Lqs -o /usr/share/fonts/truetype/SauceCodeProNerdFont-Medium.ttf "$url_font" &>/dev/null
    fc-cache -f
printf "done\n"

[ -e ~/repos/dotfiles/setup/linking.fish ] && fish ~/repos/dotfiles/setup/linking.fish
