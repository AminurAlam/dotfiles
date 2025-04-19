status is-interactive || exit
command -vq tmux || exit

if not tmux has-session -t conf 2>/dev/null
    command -vq lazygit
    and set lazygit \-n lazygit lg \; new-window \-c ~/repos/dotfiles/
    tmux new-session -c ~/repos/dotfiles/ -ds conf $lazygit
end

# if command -vq newsboat && [ (uname -o) = GNU/Linux ] && not tmux has-session -t rss 2>/dev/null
#     tmux new-session -ds rss newsboat \; set mouse off
# end

if [ (uname -o) = Android ]
    tmux has-session -t ssh 2>/dev/null || tmux new-session -ds ssh
    set -q SSH_CLIENT && tmux attach -t ssh
end
