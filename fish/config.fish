fish_config theme choose tokyo-night

### EXPORTS ###
set -gx EDITOR (command -v nvim || command -v vim || command -v vi)

# xdg
set -gx XDG_VIDEOS_DIR $HOME/Videos
set -gx XDG_DOWNLOAD_DIR $HOME/Downloads
set -gx XDG_DOCUMENTS_DIR $HOME/Documents
set -gx XDG_MUSIC_DIR $HOME/Music
set -gx XDG_PICTURES_DIR $HOME/Pictures
set -gx XDG_VIDEOS_DIR $HOME/Movies
set -gx XDG_RUNTIME_DIR $TMPDIR
set -gx XDG_PROJECTS_DIR $HOME/repos
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.local/cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state
if [ (uname -o) = Android ] && [ -d /sdcard ]
    set -gx XDG_VIDEOS_DIR /sdcard/Movies
    set -gx XDG_DOWNLOAD_DIR /sdcard/Download
    set -gx XDG_DOCUMENTS_DIR /sdcard/Documents
    set -gx XDG_MUSIC_DIR /sdcard/Music
    set -gx XDG_PICTURES_DIR /sdcard/Pictures
    set -gx XDG_VIDEOS_DIR /sdcard/Movies
end
# frequently used dirs
set dl $XDG_DOWNLOAD_DIR
set mu $XDG_MUSIC_DIR
set temp $XDG_CACHE_HOME/temp
# other
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx LESS --mouse
set -gx MANPAGER "$EDITOR +Man!"
set -gx MANPATH $PREFIX/share/fish/man $PREFIX/share/man
set -gx TERMINFO "$PREFIX/share/terminfo"
set -gx BROWSER (command -v firefox || command -v xdg-open)
set -gx LAUNCHER fzf
set -gx DISPLAY ":1"
# command config
set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
set -gx ICEAUTHORITY $XDG_CACHE_HOME/ICEauthority
set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx TAPLO_CONFIG $XDG_PROJECTS_DIR/dotfiles/other/taplo.toml
set -gx RIPGREP_CONFIG_PATH $XDG_PROJECTS_DIR/dotfiles/other/ripgreprc
set -gx FZF_DEFAULT_OPTS_FILE $XDG_PROJECTS_DIR/dotfiles/other/fzfrc
set -gx _ZO_FZF_OPTS
# lang config
set -gx JAVA_HOME $PREFIX/lib/jvm/java-21-openjdk
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -gx NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx CARGO_INSTALL_ROOT $CARGO_HOME
set -gx CARGO_LOG info
set -gx CARGO_INCREMENTAL false
set -gx VIMRUNTIME $PREFIX/share/nvim/runtime
# fish config
set -U fish_features qmark-noglob

### PATH ###
set -gxp --path PATH "$HOME/.local/bin" # sometimes before
set -gxp --path PATH "$CARGO_HOME/bin" # after declaring CARGO_HOME
set -gxp --path PATH "$HOME/.local/share/npm/bin"
set -gxp --path PATH "$HOME/.local/share/nvim/mason/bin"
set -gxp --path PATH "$PREFIX/lib/jvm/java-21-openjdk/bin"
# set -gxp --path PATH "$PREFIX/bin/texlive" # replaced by $PREFIX/etc/fish/conf.d/texlive.fish

[ (uname -o) = Android ] && set -gxa LD_PRELOAD /data/data/com.termux/files/usr/lib/libluajit.so # https://github.com/termux/termux-packages/issues/22328

### SOURCE ###
command -vq starship && starship init fish | source || source $XDG_CONFIG_HOME/fish/functions/load_prompt.fish
command -vq zoxide && zoxide init fish | source || alias z cd
dircolors ~/repos/dotfiles/eza/dircolors -c | sed 's/^setenv /set -gx /' | source

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

# TODO: tmux on startup
if status is-interactive
    if not tmux has-session -t conf 2>/dev/null
        pushd ~/repos/dotfiles/
        tmux new-session -ds conf
        popd
    end
end

function auto_pwd --on-variable PWD
    if test -d .git && git rev-parse --git-dir &>/dev/null
        git status -s
    end
end
