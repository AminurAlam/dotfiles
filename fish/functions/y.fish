function y -d "yazi wrapper to change directories"
    set tmp (mktemp -t "yazi-cwd.XXXXXX")

    for i in (seq (count $argv))
        string match -rq -- '^-' "$argv[$i]" && continue
        [ -e "$argv[$i]" ] && continue
        set resolved (zoxide query "$argv[$i]" 2>/dev/null)
        [ -z "$resolved" ] && continue
        set argv[$i] "$resolved"
        zoxide add "$resolved"
    end

    yazi --cwd-file="$tmp" $argv

    # FIX: stuck when sshfs mounted
    if set cwd (command cat -- "$tmp")
        and [ -n "$cwd" ]
        and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
