function yt -a url fmt

    if [ -z "$url" ]
        printf "no url given!\n"
        return 1
    end

    # pick and choose if no fmt given
    if [ -z "$fmt" ]
        yt-dlp --quiet --verbose --no-sponsorblock -F "$url" 2>/dev/null || return
        set -f fmt (read -fP \n' > select format: ')
        [ -z "$fmt" ] && return 2
        echo
    end

    # pick best audio for yt
    if echo $url | grep -Eq 'youtu.be|youtube.com'
        if [ $fmt != 18 -a $fmt != 22 -a $fmt != best ]
            set fmt $fmt+bestaudio
        end
    end

    # TODO: remove extra log
    yt-dlp -f "$fmt" -- "$url"
end
