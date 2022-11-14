function install-packages
    apt update && apt upgrade
    mkdir -p $PREFIX/etc/apt/
    touch $PREFIX/etc/apt/sources.list
    echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
    echo "RUNNING PACKAGE UPDATES PLEASE BE PATIENT"

    apt -y update > /dev/null 2> /dev/null
    apt -y upgrade > /dev/null 2> /dev/null

    apt -yq=10 install dust exa fd git neovim ripgrep starship zoxide lua-language-server
    apt install ffmpeg stylua tealdeer nodejs-lts rust python
    command -sq pip && pip install deflacue pyright
    command -sq cargo && cargo install skim
end

function get-repos
    command -sq git || apt -yq=10 install git

    git clone --depth 1 "https://github.com/AminurAlam/dotfiles.git" $HOME/repos/dotfiles/
    git clone --depth 1 "https://github.com/AminurAlam/musicbrainzpy.git" $HOME/repos/musicbrainzpy/
    git clone --depth 1 "https://github.com/AminurAlam/samples.git" $HOME/repos/samples/
end

function restore-configs
    set -l sha256hash b7918f3b8674f48a8f41d82411adb64549f55134dcf600d5afafe73f08fc2600
    set -l font_url https://cdn.discordapp.com/attachments/775578261173698563/1038110725987635210/font.ttf

    for directory in $HOME/repos/dotfiles/*
        [ -d "$directory" ] && command cp -fr "$directory" $HOME/.config/
    end

    command cp -fr $HOME/repos/dotfiles/starship.toml $HOME/.config/
    mkdir -p $HOME/.local/share/
    command mv $HOME/.config/cargo/ $HOME/.local/share/
    command mv $HOME/.config/termux/* $HOME/.termux/

    echo "$sha256hash $HOME/.termux/font.ttf" | sha256sum -c || curl -o $HOME/.termux/font.ttf "$font_url"
    termux-reload-settings
end

function prepare-bin
    mkdir -p $HOME/bin/
    [ -x "$PREFIX/bin/nvim" ] && ln -s "$PREFIX/bin/nvim" "$HOME/bin/termux-file-editor"
    printf 'echo $1 > $HOME/shared' > $HOME/bin/termux-url-opener
end

function setup-git
    mkdir -p $HOME/.config/git/
    touch $HOME/.config/git/config
    git config --global init.defaultBranch 'dev'
    git config --global user.name 'AminurAlam'
    read GIT_AUTHOR_EMAIL -f -P "enter your git email: " && git config --global user.email "$GIT_AUTHOR_EMAIL"
    set -e GIT_AUTHOR_EMAIL
end

install-packages
get-repos
restore-configs
prepare-bin
setup-git

[ -d "/sdcard/termux/home" ] && command cp -fr /sdcard/termux/home/* "$HOME/"
truncate -s 0 $PREFIX/etc/motd $PREFIX/etc/motd.sh
command rm -fr "$HOME/storage/"

apt remove bash-completion dos2unix ed nano
apt autoclean

source $HOME/.config/fish/config.fish
