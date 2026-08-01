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
        # if nc -w3 -q3 -z (ssh -G brick | rg --replace '' '^(hostname|port) ') 2>/dev/null
        #     ssh brick zmx list --short
        # end
    end

    if [ -z "$argv[1]" ]
        return 1
    end

    if [ "$(zmx get "$argv[1]" ssh)" = true ]
        ssh $argv
    else
        zmx attach (string replace "$ZMX_SESSION_PREFIX" "" "$argv[1]")
    end

    popd 2>/dev/null
end
