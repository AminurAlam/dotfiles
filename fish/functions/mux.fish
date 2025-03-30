function mux -d "tmux wrapper"
    if [ -n "$argv[2]" ] && command -vq zoxide
        z $argv[2]
    end

    if [ -z "$argv[1]" ]
        set argv (tmux ls -F#S | fzf)
    end

    if [ -z "$argv[1]" ]
        set argv _
    end

    tmux new-session -ds "$argv[1]" &>/dev/null

    [ -n "$TMUX" ]
    and tmux switch-client -t "$argv[1]"
    or tmux attach -t "$argv[1]"
end
