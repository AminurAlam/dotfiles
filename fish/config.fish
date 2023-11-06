# TODO: conf.d/ -> somewhere/else/ and source manually

set -gxp --path PATH "$HOME/.local/bin" # this comes first: nvim, eza, sk...

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
set -gx LAUNCHER sk --prompt '  ' --inline-info --no-multi --margin 0,3,1,3 --color \
"dark,fg:,bg:,matched:#ff9e64,matched_bg:,current:,current_bg:#2e3c64,current_match:,current_match_bg:,query:,query_bg:,info:,border:#c0caf5,prompt:,pointer:,marker:,spinner:,header:"
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
set -gx VIMRUNTIME $PREFIX/share/nvim/runtime/

set -gxp --path PATH "$CARGO_HOME/bin" # after declaring CARGO_HOME

### SOURCE ###
command -sq starship && starship init fish | source || source $XDG_CONFIG_HOME/fish/functions/load_prompt.fish
command -sq zoxide && zoxide init fish | source || alias z cd

### ALIASES ###
[ (fish -v | tr -dc [:digit:] ) -ge 360 ] && set -l cursor "--set-cursor" "%"
abbr $cursor[1] zsd "z $XDG_DIR/$cursor[2]"
abbr $cursor[1] zdoc "z $XDG_DOCUMENTS_DIR/$cursor[2]"
abbr $cursor[1] zdl "z $XDG_DOWNLOAD_DIR/$cursor[2]"
abbr $cursor[1] zmov "z $XDG_VIDEOS_DIR/$cursor[2]"
abbr $cursor[1] zmu "z $XDG_MUSIC_DIR/$cursor[2]"
abbr $cursor[1] zpic "z $XDG_PICTURES_DIR/$cursor[2]"
abbr $cursor[1] zt "z $XDG_DIR/Tachiyomi*/local/$cursor[2]"
abbr $cursor[1] zm "z $XDG_DIR/main/$cursor[2]"
abbr $cursor[1] zl "z ~/.local/$cursor[2]"
abbr $cursor[1] zmbz "z $XDG_PROJECTS_DIR/mbz-rust/$cursor[2]"
abbr $cursor[1] zd "z $XDG_PROJECTS_DIR/dotfiles/$cursor[2]"
abbr $cursor[1] zc "z $XDG_CONFIG_HOME/$cursor[2]"
abbr $cursor[1] zcf "z $XDG_CONFIG_HOME/fish/$cursor[2]"
abbr $cursor[1] zcn "z $XDG_CONFIG_HOME/nvim/$cursor[2]"
abbr $cursor[1] zp "z $PREFIX/$cursor[2]"
abbr zz "z -"

### FUNCTIONS ###
function fish_title
    printf "%s: %s" (prompt_pwd) (status current-command | string replace fish ❯)
end

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

# dust -tfn 6 --skip-total
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
