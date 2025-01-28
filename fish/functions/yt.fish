function yt -a url fmt -d "yt-dlp wrapper"
    patch $PREFIX/lib/python3.12/site-packages/yt_dlp/YoutubeDL.py --input ~/repos/dotfiles/scripts/patches/yt-dlp-YoutubeDL.py.diff --silent -f --reject-file - &>/dev/null

    if [ -z "$url" ]
        printf "no url given!\n"
        return 1
    end

    # pick and choose if no fmt given
    if [ -z "$fmt" ]
        set -f fmt (
            yt-dlp --quiet --verbose --no-sponsorblock -F "$url" 2>/dev/null \
            | fzf --tac -q "'2k | '4k | '1080p | '" \
            | cut -d ' ' -f1)
        [ -z "$fmt" ] && return 2
    end

    # pick best audio for yt
    if echo $url | grep -Eq 'youtu.be|youtube.com'
        if [ $fmt != 18 -a $fmt != 22 -a $fmt != best ]
            set fmt $fmt+bestaudio
        end
    end

    yt-dlp -f "$fmt" -- "$url"
end
