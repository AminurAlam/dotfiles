function y -d "yazi wrapper to change directories"
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    if [ -n "$argv[1]" ] && ! [ -e "$argv[1]" ]
        set argv[1] (zoxide query "$argv[1]")
        [ -e "$argv[1]" ] && zoxide add "$argv[1]"
    end

    yazi $argv --cwd-file="$tmp"

    if set cwd (command cat -- "$tmp")
        and [ -n "$cwd" ]
        and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
