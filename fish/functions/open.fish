# in /usr/share/fish/functions/open.fish
function open
    if not set -q argv[1]
        printf (_ "%ls: Expected at least %d args, got only %d\n") open 1 0 >&2
        return 1
    end

    if [ -d "$argv" ]
        cd "$argv"
    else if file "$argv" | grep -q 'ASCII text'
        $EDITOR "$argv"
    else if [ -f "$argv" ]
        termux-share "$argv"
    else if type -qf xdg-open
        xdg-open "$argv"
    else
        echo (_ 'No open utility found. Try installing "xdg-open" or "xdg-utils".') >&2
    end
end
