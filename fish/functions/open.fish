function open
    if not set -q argv[1]
        printf "%ls: Expected at least %d args, got only %d\n" open 1 0 >&2
        return 1
    end

    set -l http '^https?://(www\.)?'

    if [ -d "$argv" ]
        cd "$argv"
    else if file "$argv" | rg -q 'ASCII text'
        $EDITOR "$argv"
    else if [ -f "$argv" ]
        termux-share "$argv" &

    # HANDLE UNIQUE LINKS
    else if command -vq timg && echo "$argv" | rg -q \
    $http'.*\.(jpg|png|gif|jpeg)$' &>/dev/null
        curl -o - "$argv" | timg -w 5 -
    else if command -vq yt-dlp && echo "$argv" | rg -q \
    $http'youtu(\.be|be\.com)/'
        yt "$argv" "18"
    else if command -vq git && echo "$argv" | rg -q \
    $http'github\.com/[-a-zA-Z0-9_]+/[-a-zA-Z0-9_]+(\.git)?'
        gcp "$argv"
    else if command -vq tidal-dl && echo "$argv" | rg -q \
    $http'tidal\.com/(artist|album|track|video)'
        tidal-dl "$argv"


    else if type -qf termux-open
        xdg-open "$argv" &
    else
        echo 'No open utility found. Try installing "xdg-open" or "xdg-utils".' >&2
    end
end
