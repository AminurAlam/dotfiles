function mux -d "tmux wrapper"
    if [ -n "$argv[2]" ]
        if [ -d "$argv[2]" ]
            builtin cd "$argv[2]"
        else if command -vq zoxide
            pushd (zoxide query "$argv[2]" 2>/dev/null) 2>/dev/null
        end
    end

    if [ -z "$argv[1]" ]
        set argv (tmux ls -F#S | fzf)
    end

    if [ -z "$argv[1]" ]
        return 1
    end

    [ -n "$TMUX" ]
    and begin
        tmux new-session -ds "$argv[1]" &>/dev/null
        tmux switch-client -t "$argv[1]"
    end
    or tmux new-session -As "$argv[1]"

    popd 2>/dev/null
end
