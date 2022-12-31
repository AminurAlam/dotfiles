function install-packages
    mkdir -p $PREFIX/etc/apt/
    touch $PREFIX/etc/apt/sources.list
    echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list

    printf "\nRUNNING PACKAGE UPDATES PLEASE BE PATIENT\n"

    apt -y update > /dev/null 2> /dev/null
    apt -y upgrade > /dev/null 2> /dev/null

    apt -yq=10 install dust exa fd git neovim-nightly ripgrep starship zoxide lua-language-server termux-api stylua
    apt install python && pip install requests
end

function setup-git
    mkdir -p $HOME/.config/git/
    touch $HOME/.config/git/config

    git config --global init.defaultBranch 'dev'
    git config --global user.name 'AminurAlam'
    read GIT_AUTHOR_EMAIL -f -P "enter your git email: " && git config --global user.email "$GIT_AUTHOR_EMAIL"
    set -e GIT_AUTHOR_EMAIL

    command rm -fr "$HOME/repos/dotfiles/"
    git clone -q --depth 1 "https://github.com/AminurAlam/dotfiles.git" $HOME/repos/dotfiles/
end

function restore-configs
    for directory in $HOME/repos/dotfiles/*
        [ -d "$directory" ] && command cp -fr "$directory" $HOME/.config/
    end

    command cp -fr $HOME/repos/dotfiles/starship.toml $HOME/.config/
    mkdir -p $HOME/.local/share/
    command mv $HOME/.config/cargo/ $HOME/.local/share/
    command mv $HOME/.config/termux/* $HOME/.termux/
    rmdir $HOME/.config/termux/

    # https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/SourceCodePro.zip
    termux-reload-settings
end

function prepare-bin
    mkdir -p $HOME/bin/
    [ -d "/sdcard/main/bin/" ] && command cp -fr /sdcard/main/bin/* $HOME/bin/
    [ -x "$PREFIX/bin/nvim" ] && ln -s "$PREFIX/bin/nvim" "$HOME/bin/termux-file-editor"
    chmod +x $HOME/bin/*
end


install-packages
setup-git
restore-configs
prepare-bin

truncate -s 0 $PREFIX/etc/motd $PREFIX/etc/motd.sh
command rm -fr "$HOME/storage/"

apt autoclean

source $HOME/.config/fish/config.fish
