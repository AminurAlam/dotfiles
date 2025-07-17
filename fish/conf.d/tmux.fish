status is-interactive || exit
command -vq tmux || exit

if not tmux has-session -t conf 2>/dev/null
    command -vq lazygit
    and set lazygit \-n lazygit lg \; new-window \-c ~/repos/dotfiles/
    tmux new-session -c ~/repos/dotfiles/ -ds conf $lazygit
end

# TODO: kavita-bin
# TODO: firefox-syncstorage https://github.com/mozilla-services/syncserver
# set kavita_port 8102
# set ffsync_port 8103 # TODO: sqlite!!
