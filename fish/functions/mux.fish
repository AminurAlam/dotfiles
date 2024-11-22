function mux -d "tmux wrapper"
    if [ -n "$argv[1]" ] && tmux has-session -t "$argv[1]" # 2>/dev/null
        if [ -n "$TMUX" ]
            tmux switch-client -t "$argv[1]"
        else
            tmux attach -t "$argv[1]"
        end
    else if [ -n "$argv[1]" ]
        if [ -n "$TMUX" ]
            printf "try these instead:\n"
            tmux ls -F#S
            return
        end
        tmux new-session -s "$argv[1]"
    else if [ -z "$argv[1]" ]
        tmux attach
    end
end
