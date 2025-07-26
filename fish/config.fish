set -gx EDITOR nvim
set -gx SUDO_EDITOR nvim -u ~/repos/dotfiles/other/vimrc
set -gx LESS --mouse
set -gx MANPAGER "nvim +Man!"

# xdg
set -gx XDG_VIDEOS_DIR $HOME/Videos
set -gx XDG_DOWNLOAD_DIR $HOME/Downloads
set -gx XDG_DOCUMENTS_DIR $HOME/Documents
set -gx XDG_MUSIC_DIR $HOME/Music
set -gx XDG_PICTURES_DIR $HOME/Pictures
set -gx XDG_VIDEOS_DIR $HOME/Videos
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.local/cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

# command config
set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
set -gx ICEAUTHORITY $XDG_CACHE_HOME/ICEauthority
set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx TAPLO_CONFIG $HOME/repos/dotfiles/other/taplo.toml
set -gx RIPGREP_CONFIG_PATH $HOME/repos/dotfiles/other/ripgreprc
set -gx FZF_DEFAULT_OPTS_FILE $HOME/repos/dotfiles/other/fzfrc
set -gx WINEPREFIX $XDG_DATA_HOME/wineprefixes/default
set -gx GRADLE_USER_HOME $XDG_DATA_HOME/gradle

# lang config
set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -gx NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx GOPATH $XDG_DATA_HOME/go
set -gx GOMODCACHE $XDG_CACHE_HOME/go/mod
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx CARGO_INSTALL_ROOT $CARGO_HOME
# set -gx VIMRUNTIME $PREFIX/share/nvim/runtime

if set -q TERMUX_VERSION
    set -gx XDG_RUNTIME_DIR $TMPDIR
    set -gx TERMINFO "$PREFIX/share/terminfo"
    set -gx MANPATH $PREFIX/share/fish/man $PREFIX/share/man

    set -gx XDG_VIDEOS_DIR /sdcard/Movies
    set -gx XDG_DOWNLOAD_DIR /sdcard/Download
    set -gx XDG_DOCUMENTS_DIR /sdcard/Documents
    set -gx XDG_MUSIC_DIR /sdcard/Music
    set -gx XDG_PICTURES_DIR /sdcard/Pictures
    set -gx XDG_VIDEOS_DIR /sdcard/Movies

    set -gxp --path PATH ~/.local/bin # sometimes before
    set -gxp --path PATH "$CARGO_HOME/bin" # after declaring CARGO_HOME
    set -gxp --path PATH ~/.local/share/npm/bin
end
set -gxp --path PATH ~/.local/bin # sometimes before

status is-interactive || exit

command -vq starship && starship init fish | source || source $XDG_CONFIG_HOME/fish/functions/load_prompt.fish
command -vq zoxide && zoxide init fish | source || alias z cd
dircolors ~/repos/dotfiles/eza/dircolors -c | sed 's/^setenv /set -gx /' | source

if command -vq tmux && not tmux has-session -t conf 2>/dev/null
    command -vq lazygit
    and set lazygit \-n lazygit lg \; new-window \-c ~/repos/dotfiles/
    tmux new-session -c ~/repos/dotfiles/ -ds conf $lazygit
end

function fish_title
    prompt_pwd
end

fish_config theme choose tokyo-night
