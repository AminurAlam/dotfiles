function mux
    if string match -qr "$argv[1]" (tmux ls -F#S 2>/dev/null)
        tmux attach -t (tmux ls -F#S 2>/dev/null | $LAUNCHER --query "$argv[1]")
    else if [ -n "$argv[1]" ]
        tmux new-session -s "$argv[1]"
    end
end
