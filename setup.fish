function install-packages
    apt update && apt upgrade
    mkdir $PREFIX/etc/apt/
    touch $PREFIX/etc/apt/sources.list
    echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list

    apt update && apt upgrade
    apt install -y dust exa fd fish git neovim python ripgrep zoxide termux-api lua-language-server
    apt install ffmpeg glow stylua tealdeer luarocks nodejs-lts rust
    pip install deflacue pyright
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
    command cp -fr $HOME/repos/dotfiles/termux/* $HOME/.termux/
    termux-reload-settings
end

### ### ###

install-packages
get-repos
restore-configs

[ -d "/sdcard/termux/home" ] && command cp -fr "/sdcard/termux/home/*" "$HOME/"

echo "" > $PREFIX/etc/motd
echo "" > $PREFIX/etc/motd.sh


read GH_EMAIL -f -P "enter your github email: "
git config --global user.email "$GH_EMAIL"
git config --global user.name 'AminurAlam'
set -e GH_EMAIL

source $HOME/.config/fish/config.fish
