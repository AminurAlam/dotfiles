status is-interactive || exit
command -vq tmux || exit

if not tmux has-session -t conf 2>/dev/null
    command -vq lazygit
    and set lazygit \-n lazygit lg \; new-window \-c ~/repos/dotfiles/
    tmux new-session -c ~/repos/dotfiles/ -ds conf $lazygit
end

if [ (uname -o) = GNU/Linux ] && not tmux has-session -t servers 2>/dev/null
    tmux new-session -c ~ -ds servers -n stat btop \; \
        new-window -n anki "env SYNC_PORT=8100 SYNC_BASE=$HOME/.local/state/anki-syncserver SYNC_USER1=wehip20846@jameagle.com:wehip20846@jameagle.com anki --syncserver" \; \
        new-window -n komga "env KOMGA_CONFIGDIR=$HOME/.local/share/komga komga"
end
