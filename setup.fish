function setup-git
    printf "\nSETTING UP GIT\n\n"

    mkdir -p $HOME/.config/git/
    touch $HOME/.config/git/config

    git config --global init.defaultBranch 'dev'
    git config --global user.name 'AminurAlam'
    git config --global user.email '64137875+AminurAlam@users.noreply.github.com'
    git config --global author.name 'AminurAlam'
    git config --global author.email '64137875+AminurAlam@users.noreply.github.com'
    git config --global commiter.name 'AminurAlam'
    git config --global commiter.email '64137875+AminurAlam@users.noreply.github.com'

    command rm -fr "$HOME/repos/dotfiles/" &> /dev/null
    git clone -q --depth 1 "https://github.com/AminurAlam/dotfiles.git" $HOME/repos/dotfiles/
end

function restore-configs
    printf "\nLINKING CONFIG FILES\n\n"

    mkdir -p $HOME/.config/backup/

    function relink
        [ -d "$argv[1]" -o -e "$argv[1]" ] || return
        command mv -f $argv[2] $HOME/.config/backup/ &> /dev/null
        ln -fs $argv[1] $argv[2]
    end

    mkdir -p $HOME/.config/
    mkdir -p $HOME/.local/share/

    relink $HOME/repos/dotfiles/cargo/    $HOME/.local/share/cargo/
    relink $HOME/repos/dotfiles/fish/     $HOME/.config/fish/
    relink $HOME/repos/dotfiles/newsboat/ $HOME/.config/newsboat/
    relink $HOME/repos/dotfiles/npm/      $HOME/.config/npm/
    relink $HOME/repos/dotfiles/nvim/     $HOME/.config/nvim/
    relink $HOME/repos/dotfiles/python/   $HOME/.config/python/

    relink $HOME/repos/dotfiles/termux/colors.properties $HOME/.termux/colors.properties
    relink $HOME/repos/dotfiles/termux/termux.properties $HOME/.termux/termux.properties
    relink $HOME/repos/dotfiles/starship.toml            $HOME/.config/starship.toml

    rmdir $HOME/.config/backup/ &> /dev/null
    termux-reload-settings
end

function prepare-bin
    printf "\nPREPARING LOCAL BINARIES\n\n"

    mkdir -p $HOME/.local/bin/
    [ -d "/sdcard/main/bin/" ] && command cp -fr /sdcard/main/bin/* $HOME/.local/bin/
    command -sq nvim && ln -fs (command -s nvim) "$HOME/.local/bin/termux-file-editor"
    chmod +x $HOME/bin/*
end


pkg install dust exa fd git neovim-nightly rip ripgrep starship zoxide lua-language-server termux-api
pkg install python python-pip && pip install requests deflacue

setup-git
restore-configs
prepare-bin

truncate -s 0 $PREFIX/etc/motd $PREFIX/etc/motd.sh
[ -d  "$HOME/storage/" ] && command rm -fr "$HOME/storage/"

source $HOME/.config/fish/config.fish
