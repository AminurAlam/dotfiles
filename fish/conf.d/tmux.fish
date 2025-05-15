status is-interactive || exit
command -vq tmux || exit

if not tmux has-session -t conf 2>/dev/null
    command -vq lazygit
    and set lazygit \-n lazygit lg \; new-window \-c ~/repos/dotfiles/
    tmux new-session -c ~/repos/dotfiles/ -ds conf $lazygit
end

# RequestTTY yes
# RemoteCommand tmux new -A -s ssh
# if [ (uname -o) = Android ]
#     set -q SSH_CLIENT && tmux new-session -As ssh
# end
