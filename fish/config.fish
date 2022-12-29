### exports ###
[ -d "$EXTERNAL_STORAGE" ] || export EXTERNAL_STORAGE="$HOME"
set -gx XDG_DOCUMENTS_DIR "$EXTERNAL_STORAGE/Documents"
set -gx XDG_DOWNLOAD_DIR "$EXTERNAL_STORAGE/Download"
set -gx XDG_MUSIC_DIR "$EXTERNAL_STORAGE/Music"
set -gx XDG_PICTURES_DIR "$EXTERNAL_STORAGE/Pictures"
set -gx XDG_VIDEOS_DIR "$EXTERNAL_STORAGE/Movies"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_RUNTIME_DIR "$TMPDIR"

set -l COLORS "*.py=38;5;45:*.rs=38;5;208:*.fish=38;5;47:*.sh=38;5;47:*.bash=38;5;47:*.png=36:*.flac=36:*.log=38;5;252:*.lrc=38;5;252:\
*.cue=38;5;39:*.apk=38;5;47:*.css=38;5;135:*.csv=38;5;42:*.go=38;5;45:*.gradle=38;5;24:*.html=38;5;202:*.json=38;5;3:*.jl=38;5;213:*.js=33:\
*.kt=35:*.lua=38;5;27:*.php=38;5;63:*.pdf=38;5;124:*.md=38;5;111:*.tex=38;5;71"
set -l SKIM_COLORS "dark,fg:,bg:,matched:,matched_bg:#364A82,current:#7dcfff,current_bg:,current_match:#1d202f,current_match_bg:#ff9e64,\
query:,query_bg:,info:,border:#c0caf5,prompt:,pointer:,marker:,spinner:,header:"

set -gx LS_COLORS "$COLORS"
set -gx EXA_COLORS "$COLORS"
set -gx EDITOR "nvim"
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx MANPAGER "nvim +Man!"
set -gx BAT_PAGER "less"
set -gx TERMINFO "$PREFIX/share/terminfo/"
set -gx BROWSER "termux-open"
set -gx LAUNCHER sk --prompt '  ' --inline-info --no-multi --margin 0,3,1,3 --color "$SKIM_COLORS" --header "$(printf '─%.0s' (seq $COLUMNS))"
set -gx WWW_HOME "https://searx.work/"
set -gx LESSHISTFILE "-"
set -gx FB_DATABASE "$XDG_CONFIG_HOME/filebrowser.db"
set -gx FB_CONFIG "$XDG_CONFIG_HOME/filebrowser.json"
set -gx STARSHIP_CACHE "$XDG_DATA_HOME/starship/logs"
set -gx ATUIN_NOBIND "true"
set -gx ATUIN_SUPPRESS_TUI "true"

set -gx INPUTRC "$XDG_CONFIG_HOME/readline/inputrc"
set -gx ICEAUTHORITY "$XDG_CACHE_HOME/ICEauthority"
set -gx XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"
set -gx HISTFILE "$XDG_STATE_HOME/bash/history"
set -gx PYTHONSTARTUP "$XDG_CONFIG_HOME/python/startup.py"
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"

set -gx RUST_BACKTRACE "full"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx CARGO_INSTALL_ROOT "$CARGO_HOME"
set -gx CARGO_LOG "info"

fish_add_path $HOME/bin
fish_add_path $CARGO_HOME/bin

### source ###
command -sq starship && starship init fish | source
command -sq atuin && atuin init fish | source
command -sq zoxide && zoxide init fish | source

### main ###
set fish_greeting "$(fish_logo brcyan brcyan brgreen \| 0)"

### paths ###
set --path sd /sdcard
set --path doc /sdcard/Documents
set --path dl /sdcard/Download
set --path mov /sdcard/Movies
set --path mu /sdcard/Music
set --path pic /sdcard/Pictures
set --path tl /sdcard/Tachiyomi/logs
set --path m /sdcard/main

set --path rp "$HOME/repos"
set --path sp "$HOME/repos/samples"

### bindings ###
fish_vi_key_bindings
bind -M insert \ch 'commandline -i \~'
bind -M insert \cq exit
bind -M normal \cq 'commandline -f exit'
bind -M normal q 'commandline -f exit'
bind -M insert \e\[1\;5A 'commandline -f history-token-search-backward'
bind -M insert \e\[1\;5B 'commandline -f history-token-search-forward'

bind -M insert \( 'commandline -i \(\)' 'commandline -f backward-char'
bind -M insert \[ 'commandline -i \[\]' 'commandline -f backward-char'
bind -M insert \{ 'commandline -i \{\}' 'commandline -f backward-char'

bind \cr _atuin_search

if bind -M insert > /dev/null 2>&1
    bind -M insert \cr _atuin_search
end



### functions ###

function fish_title
    echo (prompt_pwd): (status current-command)
end

function ua
    random choice (cat ~/notes/user_agents)
end

function wa
    curl -s "https://api.wolframalpha.com/v1/result?appid=PJHXKQ-UP492G48WW&i=$(echo $argv | string escape --style=url)"
end

function texsetup
    termux-patch-texlive
    $PREFIX/share/texlive/texmf-dist/scripts/texlive-extra/texlinks.sh
end

function style
    stylua -f "$XDG_CONFIG_HOME/nvim/stylua.toml" $XDG_CONFIG_HOME/nvim/lua/co*/*.lua -c
    read choice -fP "apply the changes? [Y/n] "
    [ -z $choice -o $choice = y ] && stylua -f "$XDG_CONFIG_HOME/nvim/stylua.toml" $XDG_CONFIG_HOME/nvim/lua/co*/*.lua
end

function fade_in
    echo
    for n in (seq 236 255)
        printf '\x1b[1A\x1b[2K'
        echo -e "\033[38;5;"$n"m $argv"
        sleep 0.07
    end
end

function fish_colors
    set -l bclr (set_color normal)
    for var in (set -n | grep _color)
        set -l clr (set_color $$var)
        printf "$clr%-40s $clr%-1s$bclr\n" "$var$bclr" "$$var"
    end
end

function clean
    set -l dirs /sdcard/Android/data/*youtube "/sdcard/Android/data/com.spotify.music/" "/sdcard/DCIM/.thaumbnails/" "/sdcard/Aurora/"

    pkg clean && apt autoremove
    for dir in $dirs
        echo "  $dir"
    end
    command rm -rf $dirs 2>/dev/null
    command -sq python && pip cache purge
    echo (count (command ls -1Na)) files in HOME
end

function pw
    sleep 0.0(random 1 100)
    for __ in (seq 8)
        sleep 0.0(random 1 100)
        tr -dc 'A-Za-z0-9|{[(<>)]}@&%#^$"`_:;!?|~+\-*/=' </dev/urandom | head -c 32
        echo
    end
end


builtin functions -e prompt_pwd

function prompt_pwd
    set -l path "$PWD"

    # replacing $HOME -> ~
    set -l path (string replace -r '^'"$HOME"'($|/)' '~$1' $path)
    set -l path (string replace -r '^'"$PREFIX"'($|/)' '…$1' $path)

    # splitting to preserve last directory
    set -l all (string split -m 1 -r / $path)
    set -l path $all[1]
    set -l last $all[2..]

    # shortening and then rejoining
    echo -n (string join / (string replace -ar '(\.?[^/]{1})[^/]*' '$1' $path) $last )
end
