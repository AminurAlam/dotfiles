function yt -a url fmt -d "yt-dlp wrapper"
    [ -d "$PREFIX/lib/python3.12/" ] && set pyfile $PREFIX/lib/python3.12/site-packages/yt_dlp/YoutubeDL.py
    [ -d "$PREFIX/lib/python3.13/" ] && set pyfile $PREFIX/lib/python3.13/site-packages/yt_dlp/YoutubeDL.py
    [ -d "$PREFIX/lib/python3.14/" ] && set pyfile $PREFIX/lib/python3.14/site-packages/yt_dlp/YoutubeDL.py
    patch $pyfile --input ~/repos/dotfiles/scripts/patches/yt-dlp-YoutubeDL.py.diff --silent -f --reject-file - &>/dev/null

    if [ -z "$url" ]
        printf "no url given!\n"
        return 1
    end

    if [ -d "/home/fisher/.librewolf/cqmm902i.default-default/storage/default/https+++www.youtube.com" ]
        set -f cookies --cookies-from-browser "firefox:$HOME/.librewolf/"
    end

    # pick and choose if no fmt given
    if [ -z "$fmt" ]
        set -f fmt (
            yt-dlp $cookies --quiet --no-sponsorblock -F "$url" 2>/dev/null \
            | fzf --tac \
            | cut -d ' ' -f1)
        [ -z "$fmt" ] && return 2
    end

    # pick best audio for yt
    if echo $url | grep -Eq 'youtu.be|youtube.com'
        if [ $fmt != 18 -a $fmt != 22 -a $fmt != best ]
            set fmt $fmt+bestaudio
        end
    end


    yt-dlp $cookies -f "$fmt" -- "$url"
end
