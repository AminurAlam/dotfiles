function setup-git
    printf "\nSETTING UP GIT\n\n"

    mkdir -p $HOME/.config/git/
    touch $HOME/.config/git/config

    git config --global init.defaultBranch 'dev'
    git config --global user.name 'AminurAlam'
    git config --global user.email '64137875+AminurAlam@users.noreply.github.com'

    command rm -fr "$HOME/repos/dotfiles/"
    git clone -q --depth 1 "https://github.com/AminurAlam/dotfiles.git" $HOME/repos/dotfiles/
end

function relink
    if test -L "$argv[1]"
        ln -fs $argv[1] $argv[2]
    else
        command rm -fr $argv[2] &> /dev/null
        ln -fs $argv[1] $argv[2]
    end
end

function restore-configs
    printf "\nLINKING CONFIG FILES\n\n"

    mkdir -p $HOME/.config/
    mkdir -p $HOME/.local/share/

    ln -fs $HOME/repos/dotfiles/cargo/ $HOME/.local/share/
    ln -fs $HOME/repos/dotfiles/fish/ $HOME/.config/
    ln -fs $HOME/repos/dotfiles/newsboat/ $HOME/.config/
    ln -fs $HOME/repos/dotfiles/neomutt/ $HOME/.config/
    ln -fs $HOME/repos/dotfiles/npm/ $HOME/.config/
    ln -fs $HOME/repos/dotfiles/nvim/ $HOME/.config/
    ln -fs $HOME/repos/dotfiles/python/ $HOME/.config/

    ln -fs $HOME/repos/dotfiles/termux/colors.properties $HOME/.termux/colors.properties
    ln -fs $HOME/repos/dotfiles/termux/termux.properties $HOME/.termux/termux.properties
    ln -fs $HOME/repos/dotfiles/starship.toml $HOME/.config/starship.toml

    termux-reload-settings
end

function prepare-bin
    printf "\nPREPARING LOCAL BINARIES\n\n"
    mkdir -p $HOME/.local/bin/
    [ -d "/sdcard/main/bin/" ] && command cp -fr /sdcard/main/bin/* $HOME/.local/bin/
    command -sq nvim && ln -fs (command -s nvim) "$HOME/.local/bin/termux-file-editor"
    chmod +x $HOME/bin/*
end


pkg install dust exa fd git neovim-nightly ripgrep starship zoxide lua-language-server termux-api stylua
pkg install python python-pip && pip install requests deflacue

setup-git
restore-configs
prepare-bin

truncate -s 0 $PREFIX/etc/motd $PREFIX/etc/motd.sh
[ -d  "$HOME/storage/" ] && command rm -fr "$HOME/storage/"

source $HOME/.config/fish/config.fish

# https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/SourceCodePro.zip
