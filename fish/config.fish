### EXPORTS ###
set -gx EDITOR (command -v nvim || command -v vim || command -v vi)
set -gx SUDO_EDITOR nvim --clean
set -gx VISUAL $EDITOR
set -gx LESS --mouse
set -gx BROWSER (command -v firefox || command -v xdg-open)
set -gx LAUNCHER fuzzel --dmenu
command -vq nvim && set -gx MANPAGER "nvim +Man!"

# xdg
set -gx XDG_VIDEOS_DIR $HOME/Videos
set -gx XDG_DOWNLOAD_DIR $HOME/Downloads
set -gx XDG_DOCUMENTS_DIR $HOME/Documents
set -gx XDG_MUSIC_DIR $HOME/Music
set -gx XDG_PICTURES_DIR $HOME/Pictures
set -gx XDG_VIDEOS_DIR $HOME/Videos
set -gx XDG_PROJECTS_DIR $HOME/repos
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.local/cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state
if [ (uname -o) = Android ] && [ -d /sdcard ]
    set -gx XDG_RUNTIME_DIR $TMPDIR
    set -gx TERMINFO "$PREFIX/share/terminfo"
    set -gx DISPLAY ":3"
    set -gx MANPATH $PREFIX/share/fish/man $PREFIX/share/man

    set -gx XDG_VIDEOS_DIR /sdcard/Movies
    set -gx XDG_DOWNLOAD_DIR /sdcard/Download
    set -gx XDG_DOCUMENTS_DIR /sdcard/Documents
    set -gx XDG_MUSIC_DIR /sdcard/Music
    set -gx XDG_PICTURES_DIR /sdcard/Pictures
    set -gx XDG_VIDEOS_DIR /sdcard/Movies

    set dl $XDG_DOWNLOAD_DIR
    set mu $XDG_MUSIC_DIR
    set temp $XDG_CACHE_HOME/temp
end

# command config
set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
set -gx ICEAUTHORITY $XDG_CACHE_HOME/ICEauthority
set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx TAPLO_CONFIG $XDG_PROJECTS_DIR/dotfiles/other/taplo.toml
set -gx RIPGREP_CONFIG_PATH $XDG_PROJECTS_DIR/dotfiles/other/ripgreprc
set -gx FZF_DEFAULT_OPTS_FILE $XDG_PROJECTS_DIR/dotfiles/other/fzfrc
set -gx WINEPREFIX $XDG_DATA_HOME/wineprefixes/default
set -gx GRADLE_USER_HOME $XDG_DATA_HOME/gradle
set -gx ANKI_WAYLAND 1
set -gx GTK_USE_PORTAL 1

# lang config
set -gx JAVA_HOME $PREFIX/lib/jvm/java-21-openjdk
set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -gx NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx CARGO_INSTALL_ROOT $CARGO_HOME
set -gx CARGO_LOG info
set -gx CARGO_INCREMENTAL false
set -gx GOPATH $XDG_DATA_HOME/go
set -gx GOMODCACHE $XDG_CACHE_HOME/go/mod
set -gx VIMRUNTIME $PREFIX/share/nvim/runtime
set -gx TEXMFHOME $XDG_DATA_HOME/texmf
set -gx TEXMFVAR $XDG_CACHE_HOME/texlive/texmf-var
set -gx TEXMFCONFIG $XDG_CONFIG_HOME/texlive/texmf-config

### PATH ###
set -gxp --path PATH "$HOME/.local/bin" # sometimes before
set -gxp --path PATH "$CARGO_HOME/bin" # after declaring CARGO_HOME
set -gxp --path PATH "$HOME/.local/share/npm/bin"
set -gxp --path PATH "$HOME/.local/share/nvim/mason/bin"
set -gxp --path PATH "$PREFIX/lib/jvm/java-21-openjdk/bin"

status is-interactive || exit

### SOURCE ###

command -vq starship && starship init fish | source || source $XDG_CONFIG_HOME/fish/functions/load_prompt.fish
command -vq zoxide && zoxide init fish | source || alias z cd
dircolors ~/repos/dotfiles/eza/dircolors -c | sed 's/^setenv /set -gx /' | source

### FUNCTIONS ###
function fish_title
    printf '%s' (prompt_pwd)
end

### COLORSCHEME ###
fish_config theme choose tokyo-night
