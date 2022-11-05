function install-packages
    apt update && apt upgrade
    mkdir $PREFIX/etc/apt/
    touch $PREFIX/etc/apt/sources.list
    echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list

    apt update && apt upgrade
    apt install -y dust exa fd git neovim ripgrep starship zoxide lua-language-server
    apt install ffmpeg glow stylua tealdeer luarocks nodejs-lts rust python
    command -sq pip && pip install deflacue pyright
end

function get-repos
    command -sq git || apt install git

    git clone --depth 1 "https://github.com/AminurAlam/dotfiles.git" $HOME/repos/dotfiles/
    git clone --depth 1 "https://github.com/AminurAlam/musicbrainzpy.git" $HOME/repos/musicbrainzpy/
    git clone --depth 1 "https://github.com/AminurAlam/samples.git" $HOME/repos/samples/
    git clone --depth 1 "https://github.com/wbthomason/packer.nvim" \
        "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
end

function restore-configs
    for directory in $HOME/repos/dotfiles/*
        [ -d "$directory" ] && command cp -fr "$directory" $HOME/.config/
    end
    command cp -f "$HOME/repos/dotfiles/starship.toml" "$HOME/.config"
    command cp -fr $HOME/repos/dotfiles/termux/* "$HOME/.termux/"
    # curl -o $HOME/.termux/font.ttf "https://cdn.discordapp.com/attachments/775578261173698563/1038110725987635210/font.ttf"
    termux-reload-settings
end

### ### ###

install-packages
get-repos
restore-configs

[ -d "/sdcard/termux/home" ] && command cp -fr /sdcard/termux/home/* "$HOME/"
echo "" > $PREFIX/etc/motd
echo "" > $PREFIX/etc/motd.sh
command rm -fr "$HOME/storage/"

nvim +PackerInstall
nvim +PackerCompile

mkdir $HOME/.config/git/
touch $HOME/.config/git/config
git config --global user.name 'AminurAlam'
read GIT_AUTHOR_EMAIL -f -P "enter your git email: " && git config --global user.email "$GIT_AUTHOR_EMAIL"
set -e GIT_AUTHOR_EMAIL

apt autoclean
apt remove bash-completion dos2unix ed nano

source $HOME/.config/fish/config.fish
