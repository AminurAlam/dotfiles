### EXPORTS ###
set -l XDG_DIR (test -n "$EXTERNAL_STORAGE" && printf "$EXTERNAL_STORAGE" || printf "$HOME")
set -gx EDITOR (command -v nvim || command -v vim || command -v vi)

# xdg
set -gx XDG_VIDEOS_DIR $XDG_DIR/(test -d "$XDG_DIR/Movies" && printf Movies || printf Videos)
set -gx XDG_DOWNLOAD_DIR $XDG_DIR/(test -d "$XDG_DIR/Download" && printf Download || printf Downloads)
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
set dl $XDG_DOWNLOAD_DIR
set mu $XDG_MUSIC_DIR
set m $XDG_DIR/main
set temp $XDG_CACHE_HOME/temp
# other
# set -gx LS_COLORS "*.py=38;5;45:*.rs=38;5;208:*.fish=38;5;47:*.sh=38;5;47:*.bash=38;5;47:*.png=36:*.flac=36:*.log=38;5;252:*.lrc=38;5;252:*.cue=38;5;39:*.apk=38;5;47:*.css=38;5;135:*.csv=38;5;42:*.go=38;5;45:*.gradle=38;5;24:*.html=38;5;202:*.json=38;5;3:*.jl=38;5;213:*.js=33:*.kt=35:*.lua=38;5;27:*.php=38;5;63:*.pdf=38;5;124:*.md=38;5;111:*.tex=38;5;71"
set -gx EZA_COLORS (string join : (cat $HOME/repos/dotfiles/other/dircolors))
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx MANPAGER "$EDITOR +Man!"
set -gx MANPATH $PREFIX/share/fish/man $PREFIX/share/man
set -gx TERMINFO "$PREFIX/share/terminfo"
set -gx BROWSER termux-open
set -gx LAUNCHER fzf
set -gx DISPLAY ":1"
# command config
set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
set -gx ICEAUTHORITY $XDG_CACHE_HOME/ICEauthority
set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx RIPGREP_CONFIG_PATH $XDG_PROJECTS_DIR/dotfiles/other/ripgreprc
set -gx FZF_DEFAULT_OPTS_FILE $XDG_PROJECTS_DIR/dotfiles/other/fzfrc
set -gx _ZO_FZF_OPTS
# lang config
set -gx JAVA_HOME $PREFIX/lib/jvm/java-17-openjdk
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -gx NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx CARGO_INSTALL_ROOT $CARGO_HOME
set -gx CARGO_LOG info
set -gx VIMRUNTIME $PREFIX/share/nvim/runtime
# fish config
set -U fish_features qmark-noglob

### PATH ###
set -gxp --path PATH "$HOME/.local/bin" # sometimes before
set -gxp --path PATH "$CARGO_HOME/bin" # after declaring CARGO_HOME
set -gxp --path PATH "$HOME/.local/share/npm/bin"
set -gxp --path PATH "$PREFIX/lib/jvm/java-17-openjdk/bin"
# set -gxp --path PATH "$PREFIX/bin/texlive" # replaced by $PREFIX/etc/fish/conf.d/texlive.fish

### SOURCE ###
command -vq starship && starship init fish | source || source $XDG_CONFIG_HOME/fish/functions/load_prompt.fish
command -vq zoxide && zoxide init fish | source || alias z cd

### FUNCTIONS ###
function fish_title
    printf "%s" (prompt_pwd)
end

# command -vq starship && bind -M insert \r transient_execute
# function starship_transient_prompt_func
#     set HOUR 3600000
#     set MIN 60000
#     set SEC 1000
#     set MS $CMD_DURATION
#
#     if [ $MS -gt $HOUR ]
#         set -f time (math -s 0 $MS/$HOUR)h(math -s 0 \($MS%$HOUR\)/$MIN)m
#     else if [ $MS -gt $MIN ]
#         set -f time (math -s 0 $MS/$MIN)m(math -s 0 \($MS%$MIN\)/$SEC)s
#     else if [ $MS -gt 800 ]
#         set -f time (math -s 1 $MS/$SEC)s
#     else if [ $MS -gt 0 ]
#         set -f time (math $MS)ms
#     end
#
#     printf "[$(set_color cyan)$time$(set_color reset)] $(set_color --bold)❯ "
# end
