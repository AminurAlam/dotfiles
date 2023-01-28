### EXPORTS ###

# setup
switch (uname -o)
    case Android; set -gx XDG_DIR "$EXTERNAL_STORAGE"
    case '*';     set -gx XDG_DIR "$HOME"
end

set -l COLORS "*.py=38;5;45:*.rs=38;5;208:*.fish=38;5;47:*.sh=38;5;47:*.bash=38;5;47:*.png=36:*.flac=36:*.log=38;5;252:*.lrc=38;5;252:*.cue=38;5;39:*.apk=38;5;47:*.css=38;5;135:*.csv=38;5;42:*.go=38;5;45:*.gradle=38;5;24:*.html=38;5;202:*.json=38;5;3:*.jl=38;5;213:*.js=33:*.kt=35:*.lua=38;5;27:*.php=38;5;63:*.pdf=38;5;124:*.md=38;5;111:*.tex=38;5;71"
set -l SKIM_COLORS "dark,fg:,bg:,matched:,matched_bg:#364A82,current:#7dcfff,current_bg:,current_match:#1d202f,current_match_bg:#ff9e64,query:,query_bg:,info:,border:#c0caf5,prompt:,pointer:,marker:,spinner:,header:"

if      command -sq nvim;   set -gx EDITOR "nvim"
else if command -sq neovim; set -gx EDITOR "neovim"
else if command -sq vim;    set -gx EDITOR "vim"
end

# xdg
set -gx XDG_DOCUMENTS_DIR $XDG_DIR/Documents
[ -d "$XDG_DIR/Download" ] &&
set -gx XDG_DOWNLOAD_DIR $XDG_DIR/Download ||
set -gx XDG_DOWNLOAD_DIR $XDG_DIR/Downloads
set -gx XDG_MUSIC_DIR $XDG_DIR/Music
set -gx XDG_PICTURES_DIR $XDG_DIR/Pictures
set -gx XDG_VIDEOS_DIR $XDG_DIR/Movies
[ -d "$XDG_DIR/Movies" ] &&
set -gx XDG_VIDEOS_DIR $XDG_DIR/Movies ||
set -gx XDG_VIDEOS_DIR $XDG_DIR/Videos
set -gx XDG_RUNTIME_DIR $TMPDIR
set -gx XDG_PROJECTS_DIR $HOME/repos
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.local/cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

# dirs
set --path sd $XDG_DIR
set --path doc $XDG_DOCUMENTS_DIR
set --path dl $XDG_DOWNLOAD_DIR
set --path mov $XDG_VIDEOS_DIR
set --path mu $XDG_MUSIC_DIR
set --path pic $XDG_PICTURES_DIR
set --path tl $XDG_DIR/Tachiyomi/local
set --path m $XDG_DIR/main
set --path rp $XDG_PROJECTS_DIR

set -gx LS_COLORS "$COLORS"
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

set -gx MANPAGER "$EDITOR +Man!"
set -gx TERMINFO "$PREFIX/share/terminfo"
set -gx BROWSER "termux-open"
set -gx LAUNCHER sk --prompt '  ' --inline-info --no-multi --margin 0,3,1,3 --color "$SKIM_COLORS"
set -gx WWW_HOME "https://searx.work/"

# command config
set -gx LESSHISTFILE -
set -gx FB_DATABASE $XDG_CONFIG_HOME/filebrowser.db
set -gx FB_CONFIG $XDG_CONFIG_HOME/filebrowser.json
set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
set -gx INPUTRC $XDG_CONFIG_HOME/readline/inputrc
set -gx ICEAUTHORITY $XDG_CACHE_HOME/ICEauthority
set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -gx HISTFILE $XDG_STATE_HOME/bash/history

# lang config
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -gx NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx RUST_BACKTRACE full
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx CARGO_INSTALL_ROOT $CARGO_HOME
set -gx CARGO_LOG info

### PATH ###
[ -d "$HOME/bin" ]        && fish_add_path $HOME/bin
[ -d "$HOME/.local/bin" ] && fish_add_path $HOME/.local/bin
[ -d "$CARGO_HOME/bin" ]  && fish_add_path $CARGO_HOME/bin

### SOURCE ###
command -sq starship && starship init fish | source || source $XDG_CONFIG_HOME/fish/functions/load_prompt.fish
command -sq zoxide   && zoxide init fish   | source || alias z cd

### MAIN ###
set fish_greeting "$(fish_logo brcyan brcyan brgreen \| 0)"

### BINDINGS ###
fish_vi_key_bindings
bind -M insert \cq exit
bind -M insert \cr 'commandline -f history-pager'
bind -M insert \e\[1\;5A 'commandline -f history-token-search-backward'
bind -M insert \e\[1\;5B 'commandline -f history-token-search-forward'

# auto pair - https://github.com/laughedelic/pisces
set fish_function_path $fish_function_path $XDG_CONFIG_HOME/fish/functions/pisces

bind -M insert '(' "_pisces_insert_left \( \)"
bind -M insert '[' "_pisces_insert_left \[ \]"
bind -M insert '{' "_pisces_insert_left \{ \}"
bind -M insert '"' '_pisces_insert_left \" \"'
bind -M insert "'" "_pisces_insert_left \' \'"

bind -M insert \b _pisces_backspace # normal backspace, also known as \010 or ^H:
bind -M insert \177 _pisces_backspace # Terminal.app sends DEL code on ⌫:
bind -M insert \t _pisces_complete # overrides TAB to provide completion of vars before a closing '"'

### ALIASES ###
alias zsd "z $XDG_DIR"
  alias zdoc "z $XDG_DOCUMENTS_DIR"
  alias zdl "z $XDG_DOWNLOAD_DIR"
  alias zmov "z $XDG_VIDEOS_DIR"
  alias zmu "z $XDG_MUSIC_DIR"
  alias zpic "z $XDG_PICTURES_DIR"
  alias zt "z $XDG_DIR/Tachiyomi"
    alias ztl "z $XDG_DIR/Tachiyomi/local"
  alias zm "z $XDG_DIR/main"
    alias zn "z $XDG_DIR/main/notes"

alias zr 'z (command ls -1N $XDG_PROJECTS_DIR | $LAUNCHER)'
alias zrp "z $XDG_PROJECTS_DIR"
  alias zmbz "z $XDG_PROJECTS_DIR/musicbrainzpy"
  alias zd "z $XDG_PROJECTS_DIR/dotfiles"

alias zc "z $XDG_CONFIG_HOME"
  alias zcf "z $XDG_CONFIG_HOME/fish"
  alias zcn "z $XDG_CONFIG_HOME/nvim"

alias zp "z $PREFIX"
alias gl "git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold yellow)%d%C(reset)' --all"
alias zz "z -"
alias .. "z .."
alias ... "z ../.."
alias .... "z ../../.."

### FUNCTIONS ###

function fish_title
    echo (prompt_pwd): (status current-command)
end

function wa
    curl -s https://api.wolframalpha.com/v1/result?appid=PJHXKQ-UP492G48WW&i=$(echo $argv | string escape --style=url)
end

# in /usr/share/fish/functions/open.fish
function open
    if not set -q argv[1]
        printf (_ "%ls: Expected at least %d args, got only %d\n") open 1 0 >&2
        return 1
    end

    if [ -d "$argv" ]
        cd "$argv"
    else if [ -f "$argv" ]
        if file "$argv" | grep 'ASCII text'
            $EDITOR "$argv"
        end
    else if type -qf xdg-open
        for i in $argv
            xdg-open $i &
            disown $last_pid 2>/dev/null
        end
    else
        echo (_ 'No open utility found. Try installing "xdg-open" or "xdg-utils".') >&2
    end
end
