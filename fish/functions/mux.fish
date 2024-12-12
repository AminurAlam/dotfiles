function mux -d "tmux wrapper"
    if [ -n "$argv[2]" ] && command -vq zoxide
        z $argv[2]
    end

    if [ -z "$argv[1]" ]
        set argv (tmux ls -F#S | fzf)
    end

    if [ -n "$argv[1]" ] && tmux has-session -t "$argv[1]" && [ -n "$TMUX" ]
        # the requested session exists and you are in tmux
        tmux switch-client -t "$argv[1]"
    else if [ -n "$argv[1]" ] && tmux has-session -t "$argv[1]"
        # the requested session exists
        tmux attach -t "$argv[1]"
    else if [ -n "$argv[1]" ]
        # the requested session doesnt exists
        tmux new-session -ds "$argv[1]"
        tmux attach -t "$argv[1]"
    else if [ -z "$argv[1]" ]
        # start unnamed sesh
        tmux
    end
end
