### exports ###
[ -d "$EXTERNAL_STORAGE" ] || export EXTERNAL_STORAGE="$HOME"
export XDG_DOCUMENTS_DIR="$EXTERNAL_STORAGE/Documents"
export XDG_DOWNLOAD_DIR="$EXTERNAL_STORAGE/Download"
export XDG_MUSIC_DIR="$EXTERNAL_STORAGE/Music"
export XDG_PICTURES_DIR="$EXTERNAL_STORAGE/Pictures"
export XDG_VIDEOS_DIR="$EXTERNAL_STORAGE/Movies"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="$TMPDIR"

set -l COLORS "*.py=38;5;45:*.rs=38;5;208:*.fish=38;5;47:*.sh=38;5;47:*.bash=38;5;47:*.png=36:*.flac=36:*.log=38;5;252:*.lrc=38;5;252:\
*.cue=38;5;39:*.apk=38;5;47:*.css=38;5;135:*.csv=38;5;42:*.go=38;5;45:*.gradle=38;5;24:*.html=38;5;202:*.json=38;5;3:*.jl=38;5;213:*.js=33:\
*.kt=35:*.lua=38;5;27:*.php=38;5;63:*.pdf=38;5;124:*.md=38;5;111:*.tex=38;5;71"
export LS_COLORS="$COLORS"
export EXA_COLORS="$COLORS"
export EDITOR="nvim"
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR
export MANPAGER="vi +Man!"
export BAT_PAGER="less"
export BROWSER="termux-open"
export WWW_HOME="https://searx.work/"
export LESSHISTFILE="-"
export RUST_BACKTRACE="full"
export FB_DATABASE="$XDG_CONFIG_HOME/filebrowser.db"
export FB_CONFIG="$XDG_CONFIG_HOME/filebrowser.json"
export STARSHIP_CACHE="$XDG_DATA_HOME/starship/logs"

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export HISTFILE="$XDG_STATE_HOME/bash/history"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CARGO_INSTALL_ROOT="$CARGO_HOME"

fish_add_path $HOME/bin
fish_add_path $CARGO_HOME/bin

### source ###
# source $HOME/.config/fish/completions/*.fish $HOME/.config/fish/functions/*.fish $HOME/.config/fish/conf.d/*.fish
source (starship init fish --print-full-init | psub)

### main ###
set fish_greeting "$(fish_logo cyan cyan green \| 0)"

### paths ###
set --path sd "/sdcard"
set --path doc "/sdcard/Documents"
set --path dl "/sdcard/Download"
set --path mov "/sdcard/Movies"
set --path mu "/sdcard/Music"
set --path pic "/sdcard/Pictures"
set --path td "/sdcard/Tachiyomi/downloads"
set --path tl "/sdcard/Tachiyomi/local"
set --path tx "/sdcard/termux"

set --path rp "$HOME/repos"
set --path sp "$HOME/repos/samples"

### bindings ###
fish_vi_key_bindings
bind -M insert \ch 'commandline -i \~'
bind -M insert \cq 'exit'
bind -M normal \cq ':q'
bind -M normal q ':q'
bind -M insert \e\[1\;5A 'commandline -f history-token-search-backward'
bind -M insert \e\[1\;5B 'commandline -f history-token-search-forward'

bind -M insert \( 'commandline -i \(\)' 'commandline -f backward-char'
bind -M insert \[ 'commandline -i \[\]' 'commandline -f backward-char'
bind -M insert \{ 'commandline -i \{\}' 'commandline -f backward-char'

### functions ###

function clean
    echo -e (set_color cyan) "\napt & pkg" (set_color normal)
    pkg clean
    apt autoremove

    echo -e (set_color cyan) "\nsdcard folders" (set_color normal)
    set -l dirs \
        "/sdcard/Android/data/com.*.youtube/" \
        "/sdcard/Android/data/org.telegram.messenger.web/" \
        "/sdcard/Android/data/com.spotify.music/" \
        "/sdcard/Android/data/com.xodo.pdf.reader/" \
        "/sdcard/DCIM/.thumbnails/" \
        "/sdcard/.TotalCommander/" \
        "/sdcard/Aurora/"

    for dir in $dirs
        echo "  $dir"
    end
    command rm -rfI $dirs

    echo -e (set_color cyan) "\npython" (set_color normal)
    command -sq python && pip cache purge

    echo -e (set_color cyan) "\nfiles in home" (set_color normal)
    count (ls -a $HOME)
end

function wa
    curl -s "https://api.wolframalpha.com/v1/result?appid=PJHXKQ-UP492G48WW&i=$(echo $argv | string escape --style=url)"
end

function texsetup
    termux-patch-texlive
    $PREFIX/share/texlive/texmf-dist/scripts/texlive-extra/texlinks.sh
end

function fish_title
    echo (prompt_pwd): (status current-command)
end

function pw
    set -l chars 'A-Za-z0-9|{[(<>)]}@&%#^$"`_:;!?|~+\-*/='
    sleep (math (random 1 100)/1000)
    for __ in (seq 8)
        sleep (math (random 1 100)/1000)
        :;: && tr -dc "$chars" < /dev/urandom | head -c 32
        echo
    end
end

function style
    set -l sheet "$HOME/.config/nvim/stylua.toml"

    stylua -f $sheet $HOME/.config/nvim/lua/*.lua -c
    read choice -fP "apply the changes? [Y/n] "
    if test -z $choice -o $choice = "y"
        stylua -f $sheet $HOME/.config/nvim/lua/*.lua
    end

    stylua -f $sheet $HOME/.config/nvim/lua/configs/*.lua -c
    read choice -fP "apply the changes? [Y/n] "
    if test -z $choice -o $choice = "y"
        stylua -f $sheet $HOME/.config/nvim/lua/configs/*.lua
    end
end
