function mux -d "zmx wrapper"
    if [ -n "$argv[2]" ]
        if [ -d "$argv[2]" ]
            pushd "$argv[2]"
        else if command -vq zoxide
            pushd (zoxide query "$argv[2]" 2>/dev/null) 2>/dev/null
        end
    end

    if [ -z "$argv[1]" ]
        set argv (zmx list --short | fzf)
    end

    if [ -z "$argv[1]" ]
        return 1
    end

    zmx attach "$argv[1]"
    popd 2>/dev/null
end
