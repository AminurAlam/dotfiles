function install-packages # TODO: support other package managers
    # setting up mirror links
    echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
    echo "deb https://packages-cf.termux.dev/apt/termux-x11 x11 main" > $PREFIX/etc/apt/sources.list.d/x11.list

    apt update && apt upgrade
    apt install -y dust exa fd fish git neovim python rclone ripgrep wget zoxide
    apt install -y termux-api tur-repo lua-language-server
    apt install duf ffmpeg fzf glow mediainfo newsboat sox stylua tealdeer w3m zip
    apt install luarocks stylua nodejs-lts rust
    pip install yt-dlp deflacue pyright
end

function get-repository
    # checking if git exists
    command -sq git || apt install git

    git clone --depth 1 "https://github.com/AminurAlam/dotfiles.git" $HOME/repos/dotfiles/
    git clone --depth 1 "https://github.com/AminurAlam/musicbrainzpy.git" $HOME/repos/musicbrainzpy/
    git clone --depth 1 "https://github.com/AminurAlam/samples.git" $HOME/repos/samples/
    git clone --depth 1 "https://github.com/wbthomason/packer.nvim" \
        "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
end

function restore-configs
    for directory in $HOME/repos/dotfiles/*
        command cp -fr "$directory" $HOME/.config/
    end
    command cp -fr $HOME/repos/dotfiles/termux/* $HOME/.termux/
end

### ### ###
# TODO: auto install nvim packages

chsh -s fish

read choice -P "download packages? [y/n] "
[ $choice = "y" ] && install-packages

get-repos
restore-configs

mkdir "$HOME/bin/"
ln -s "$PREFIX/bin/nvim" "$HOME/bin/termux-file-editor"

[ -d "/sdcard/termux/home" ] && command cp -fr "/sdcard/termux/home" "$HOME/"

nvim +PackerInstall

source $HOME/.config/fish/config.fish
