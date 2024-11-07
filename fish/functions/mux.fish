function mux
    if string match -qr "$argv[1]" (tmux ls -F#S 2>/dev/null)
        set sesh (tmux ls -F#S 2>/dev/null | fzf -1 --query "$argv[1]")
        if [ -n "$TMUX" ]
            tmux switch-client -t "$sesh"
        else
            tmux attach -t "$sesh"
        end
    else if [ -n "$argv[1]" ]
        tmux new-session -s "$argv[1]"
    end
end
