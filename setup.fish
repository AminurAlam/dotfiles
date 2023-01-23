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

function restore-configs
    printf "\nRESTORING CONFIG FILES\n\n"
    for directory in $HOME/repos/dotfiles/*
        [ -d "$directory" ] && command cp -fr "$directory" $HOME/.config/
    end

    command cp -fr $HOME/repos/dotfiles/starship.toml $HOME/.config/
    mkdir -p $HOME/.local/share/
    command mv -f $HOME/.config/cargo/ $HOME/.local/share/
    command mv $HOME/.config/termux/* $HOME/.termux/
    rmdir $HOME/.config/termux/

    # https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/SourceCodePro.zip
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
