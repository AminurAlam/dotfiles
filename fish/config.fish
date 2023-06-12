### EXPORTS ###

# setup
switch (uname -o)
    case Android; set -gx XDG_DIR "$EXTERNAL_STORAGE"
    case '*';     set -gx XDG_DIR "$HOME"
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
set -gx MANPATH $PREFIX/share/man
set -gx TERMINFO "$PREFIX/share/terminfo"
set -gx BROWSER termux-open
set -gx LAUNCHER sk --prompt '  ' --inline-info --no-multi --margin 0,3,1,3 --color "\
dark,fg:,bg:,matched:#ff9e64,matched_bg:,current:,current_bg:#2e3c64,current_match:,current_match_bg:,query:,query_bg:,info:,border:#c0caf5,prompt:,pointer:,marker:,spinner:,header:"
set -gx WWW_HOME "https://search.rowie.at"
# command config
set -gx LESSHISTFILE -
set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
set -gx INPUTRC $XDG_CONFIG_HOME/readline/inputrc
set -gx ICEAUTHORITY $XDG_CACHE_HOME/ICEauthority
set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -gx HISTFILE $XDG_STATE_HOME/bash/history
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx NVIM_APPNAME nvim
set -gx VIM "$PREFIX/share/nvim"
set -gx VIMRUNTIME "$PREFIX/share/nvim/runtime"
# lang config
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -gx NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx CARGO_INSTALL_ROOT $CARGO_HOME
set -gx CARGO_LOG info
set -gx UV_USE_IO_URING 0 # libuv/libuv#4010

### PATH ###
set -gxp --path PATH "$CARGO_HOME/bin"
set -gxp --path PATH "$HOME/.local/bin"

### SOURCE ###
command -sq starship && starship init fish | source || source $XDG_CONFIG_HOME/fish/functions/load_prompt.fish
command -sq zoxide   && zoxide init fish   | source || alias z cd # TODO: pre populate/backup zoxidu db

### BINDINGS ###
fish_vi_key_bindings
bind -M insert \e\[1\;5A 'commandline -f history-token-search-backward'
bind -M insert \e\[1\;5B 'commandline -f history-token-search-forward'
bind -M insert \\cw 'commandline -f backward-kill-bigword'

### ALIASES ###
abbr zsd "z $XDG_DIR/"
  abbr zdoc "z $XDG_DOCUMENTS_DIR/"
  abbr zdl  "z $XDG_DOWNLOAD_DIR/"
  abbr zmov "z $XDG_VIDEOS_DIR/"
  abbr zmu  "z $XDG_MUSIC_DIR/"
  abbr zpic "z $XDG_PICTURES_DIR/"
abbr zt   "z $XDG_DIR/Tachiyomi*/local"
abbr zm   "z $XDG_DIR/main/"
abbr zl "z ~/.local/"
abbr zr   'z (command ls -1N $XDG_PROJECTS_DIR | $LAUNCHER)'
abbr zrp  "z $XDG_PROJECTS_DIR/ && git clone --depth 1"
  abbr zmbz "z $XDG_PROJECTS_DIR/musicbrainzpy/"
  abbr zd   "z $XDG_PROJECTS_DIR/dotfiles/"
abbr zc   "z $XDG_CONFIG_HOME/"
  abbr zcf  "z $XDG_CONFIG_HOME/fish/"
  abbr zcn  "z $XDG_CONFIG_HOME/nvim/"
abbr zp "z $PREFIX/"
abbr zz "z -"

### FUNCTIONS ###
function fish_title
    printf "%s: %s" (prompt_pwd) (status current-command | string replace fish ❯)
end

# make zoxide completions actually useful
function __zoxide_z_complete
    set -l token (commandline -t)
    complete --do-complete "'' "(commandline --cut-at-cursor --current-token) | string match --regex '.*/$'
    [ -n "$token" ] && zoxide query --exclude "$(pwd -L)" -l -- "$token" | string replace "$HOME" '~'
end

function quit
    if [ (count (ps -C fish)) = 2 ]
        pkill com.termux
    else
        exit
    end
end

set fish_greeting "$(fish_logo)"
bind -M insert \cq quit
bind -M insert \cd quit
bind q quit

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
