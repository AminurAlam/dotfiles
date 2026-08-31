function mux -d "zmx wrapper"
    if [ -z "$argv[1]" ]
        set argv (printf "%s\n" (zmx list --short) "$ZMX_SESSION_PREFIX"conf | sort -u | fzf --print-query)[-1]
        # if nc -w3 -q3 -z (ssh -G brick | rg --replace '' '^(hostname|port) ') 2>/dev/null
        #     ssh brick zmx list --short
        # end
    end

    if [ -z "$argv[1]" ]
        return 1
    end

    # set directory
    if [ -n "$argv[2]" ]
        [ -d "$argv[2]" ]
        and pushd "$argv[2]"
        or pushd (zoxide query "$argv[2]" 2>/dev/null) 2>/dev/null
    else
        switch "$argv[1]"
            case {$ZMX_SESSION_PREFIX,}conf
                pushd ~/repos/dotfiles/
            case {$ZMX_SESSION_PREFIX,}yt
                pushd ~/vid/yt
            case {$ZMX_SESSION_PREFIX,}site
                pushd ~/repos/aminuralam.github.io
            case {$ZMX_SESSION_PREFIX,}lewd
                pushd "/sdcard/Tachi/downloads/HentaiNexus (EN)/"
            case {$ZMX_SESSION_PREFIX,}tachi
                pushd /sdcard/Tachi/local
        end
    end

    if [ "$(zmx get "$argv[1]" ssh)" = true ]
        ssh $argv
    else
        zmx attach (string replace "$ZMX_SESSION_PREFIX" "" "$argv[1]")
    end

    popd 2>/dev/null
end
