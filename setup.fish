
function install-primary-packages
    echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
    echo "deb https://packages-cf.termux.dev/apt/termux-x11 x11 main" > $PREFIX/etc/apt/sources.list.d/x11.list
    apt install dust exa fd fish git neovim python rclone ripgrep wget zoxide
end

function install-secondary-packages
    echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
    echo "deb https://packages-cf.termux.dev/apt/termux-x11 x11 main" > $PREFIX/etc/apt/sources.list.d/x11.list
    apt install duf ffmpeg fzf glow mediainfo newsboat
    apt install sox stylua tealdeer w3m zip
    apt install termux-api tur-repo
    apt install lua-language-server luarocks stylua nodejs-lts rust
end

function install-python-packages
    pip install yt-dlp deflacue
end

function get-repository
    mkdir $HOME/repos/
    git clone --depth 1 "https://github.com/AminurAlam/dotfiles.git" $HOME/repos/dotfiles/
    git clone --depth 1 "https://github.com/AminurAlam/musicbrainzpy.git" $HOME/repos/musicbrainzpy/
    git clone --depth 1 "https://github.com/AminurAlam/samples.git" $HOME/repos/samples/
end

function restore-configs
    for directory in $HOME/repos/dotfiles/*
        # command cp -r "$directory" $HOME/.config/
        echo "$directory" $HOME/.config/
    end
end

# install-primary-packages
# install-secondary-packages
# install-python-packages
# get-repos
restore-configs
