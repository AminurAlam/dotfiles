set -gxp --path PATH "$HOME/.local/bin" # this comes first: nvim, exa, sk...

### EXPORTS ###

# setup
switch (uname -o)
    case Android
        set -gx XDG_DIR "$EXTERNAL_STORAGE"
    case '*'
        set -gx XDG_DIR "$HOME"
end

if command -sq nvim
    set -gx EDITOR nvim
else if command -sq neovim
    set -gx EDITOR neovim
else if command -sq vim
    set -gx EDITOR vim
end

# xdg
[ -d "$XDG_DIR/Movies" ] &&
    set -gx XDG_VIDEOS_DIR $XDG_DIR/Movies ||
    set -gx XDG_VIDEOS_DIR $XDG_DIR/Videos
[ -d "$XDG_DIR/Download" ] &&
    set -gx XDG_DOWNLOAD_DIR $XDG_DIR/Download ||
    set -gx XDG_DOWNLOAD_DIR $XDG_DIR/Downloads
set -gx XDG_DOCUMENTS_DIR $XDG_DIR/Documents
set -gx XDG_MUSIC_DIR $XDG_DIR/Music
set -gx XDG_PICTURES_DIR $XDG_DIR/Pictures
set -gx XDG_VIDEOS_DIR $XDG_DIR/Movies
set -gx XDG_RUNTIME_DIR $TMPDIR
set -gx XDG_PROJECTS_DIR $HOME/repos
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.local/cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state
# dirs
set sd $XDG_DIR
set doc $XDG_DOCUMENTS_DIR
set dl $XDG_DOWNLOAD_DIR
set mov $XDG_VIDEOS_DIR
set mu $XDG_MUSIC_DIR
set pic $XDG_PICTURES_DIR
set m $XDG_DIR/main
set temp $XDG_CACHE_HOME/temp
set rp $XDG_PROJECTS_DIR
# other
set -gx LS_COLORS "*.py=38;5;45:*.rs=38;5;208:*.fish=38;5;47:*.sh=38;5;47:*.bash=38;5;47:*.png=36:*.flac=36:*.log=38;5;252:*.lrc=38;5;252:*.cue=38;5;39:*.apk=38;5;47:*.css=38;5;135:*.csv=38;5;42:*.go=38;5;45:*.gradle=38;5;24:*.html=38;5;202:*.json=38;5;3:*.jl=38;5;213:*.js=33:*.kt=35:*.lua=38;5;27:*.php=38;5;63:*.pdf=38;5;124:*.md=38;5;111:*.tex=38;5;71"
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx MANPAGER "$EDITOR +Man!"
set -gx MANPATH $PREFIX/share/fish/man $PREFIX/share/man
set -gx TERMINFO "$PREFIX/share/terminfo"
set -gx BROWSER termux-open
set -gx LAUNCHER sk --prompt '  ' --inline-info --no-multi --margin 0,3,1,3 --color "\
dark,fg:,bg:,matched:#ff9e64,matched_bg:,current:,current_bg:#2e3c64,current_match:,current_match_bg:,query:,query_bg:,info:,border:#c0caf5,prompt:,pointer:,marker:,spinner:,header:"
set -gx WWW_HOME "https://search.rowie.at"
set -gx DISPLAY ":1"
# command config
set -gx LESSHISTFILE -
set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
set -gx INPUTRC $XDG_CONFIG_HOME/readline/inputrc
set -gx ICEAUTHORITY $XDG_CACHE_HOME/ICEauthority
set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -gx HISTFILE $XDG_STATE_HOME/bash/history
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx RIPGREP_CONFIG_PATH $XDG_PROJECTS_DIR/dotfiles/other/ripgreprc
# lang config
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -gx NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx CARGO_INSTALL_ROOT $CARGO_HOME
set -gx CARGO_LOG info
set -gx UV_USE_IO_URING 0 # libuv/libuv#4010

set -gxp --path PATH "$CARGO_HOME/bin" # after declaring CARGO_HOME

### SOURCE ###
command -sq starship && starship init fish | source || source $XDG_CONFIG_HOME/fish/functions/load_prompt.fish
command -sq zoxide && zoxide init fish | source || alias z cd # TODO: pre populate/backup zoxidu db

### BINDINGS ###
fish_vi_key_bindings
bind -M insert \e\[1\;5A 'commandline -f history-token-search-backward'
bind -M insert \e\[1\;5B 'commandline -f history-token-search-forward'
bind -M insert \cw 'commandline -f backward-kill-bigword'

### ALIASES ###
abbr zsd "z $XDG_DIR/"
abbr zdoc "z $XDG_DOCUMENTS_DIR/"
abbr zdl "z $XDG_DOWNLOAD_DIR/"
abbr zmov "z $XDG_VIDEOS_DIR/"
abbr zmu "z $XDG_MUSIC_DIR/"
abbr zpic "z $XDG_PICTURES_DIR/"
abbr zt "z $XDG_DIR/Tachiyomi*/local"
abbr zm "z $XDG_DIR/main/"
abbr zl "z ~/.local/"
abbr zmbz "z $XDG_PROJECTS_DIR/musicbrainzpy/"
abbr zd "z $XDG_PROJECTS_DIR/dotfiles/"
abbr zc "z $XDG_CONFIG_HOME/"
abbr zcf "z $XDG_CONFIG_HOME/fish/"
abbr zcn "z $XDG_CONFIG_HOME/nvim/"
abbr zp "z $PREFIX/"
abbr zz "z -"

### FUNCTIONS ###
function fish_title
    printf "%s: %s" (prompt_pwd) (status current-command | string replace fish ❯)
end

set -l m (set_color brcyan)
set -l i (set_color brgreen)
set -l o (set_color brcyan)
set -l pad (string repeat -Nn (math -s 0 "($COLUMNS/2) - 20") " ")

set fish_greeting $pad'                 '$o'___'\n \
    $pad'  ___======____='$m'-'$i'-'$m'-='$o')'\n \
    $pad'/T            \_'$i'--='$m'=='$o')'\n \
    $pad'| \ '$m'('$i'0'$m')   '$o'\~    \_'$i'-='$m'='$o')'\n \
    $pad' \      / )J'$m'~~    '$o'\\'$i'-='$o')'\n \
    $pad'  \\\\___/  )JJ'$m'~'$i'~~   '$o'\)'\n \
    $pad'   \_____/JJJ'$m'~~'$i'~~    '$o'\\'\n \
    $pad'   '$m'/ '$o'\  '$i', \\'$o'J'$m'~~~'$i'~~     '$m'\\'\n \
    $pad'  (-'$i'\)'$o'\='$m'|'$i'\\\\\\'$m'~~'$i'~~       '$m'L_'$i'_'\n \
    $pad'  '$m'('$o'\\'$m'\\)  ('$i'\\'$m'\\\)'$o'_           '$i'\=='$m'__'\n \
    $pad'   '$o'\V    '$m'\\\\'$o'\) =='$m'=_____   '$i'\\\\\\\\'$m'\\\\'\n \
    $pad'          '$o'\V)     \_) '$m'\\\\'$i'\\\\JJ\\'$m'J\)'\n \
    $pad'                      '$o'/'$m'J'$i'\\'$m'J'$o'T\\'$m'JJJ'$o'J)'\n \
    $pad'                      (J'$m'JJ'$o'| \UUU)'\n \
    $pad'                       (UU)'

# command -sq starship && bind -M insert \r transient_execute
# function starship_transient_prompt_func
#     if [ $CMD_DURATION -gt 3600000 ]
#         set -f time " [$(math -s 0 $CMD_DURATION/3600_000)h$(math -s 0 \($CMD_DURATION%3600_000\)/60_000)m]"
#     else if [ $CMD_DURATION -gt 60000 ]
#         set -f time " [$(math -s 0 $CMD_DURATION/60_000)m$(math -s 0 \($CMD_DURATION%60_000\)/1_000)s]"
#     else if [ $CMD_DURATION -gt 800 ]
#         set -f time " [$(math -s 1 $CMD_DURATION/1_000)s]"
#     else if [ $CMD_DURATION -gt 10 ]
#         set -f time " [$(echo $CMD_DURATION)ms]"
#     end
#
#     printf "%s%s %s%s " \
#         (set_color cyan) $time \
#         (set_color normal) "❯"
# end

# function result
#     set -l flac (fd 'flac$' | count)
#     set -l mp3 (fd 'mp3$'  | count)
#     set -l ogg (fd 'ogg$'  | count)
#     set -l total (math $flac + $mp3 + $ogg)
#     printf " %s%% %s - %d\n" \
#         (math -s 2 $flac / $total x 100) FLAC $flac \
#         (math -s 2 $mp3  / $total x 100) MP3 $mp3 \
#         (math -s 2 $ogg  / $total x 100) OGG $ogg
# end
