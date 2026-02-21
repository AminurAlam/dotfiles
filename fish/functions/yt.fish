function yt -a url fmt -d "yt-dlp wrapper"
    for ver in 12 13 14 15
        [ -e "$PREFIX/lib/python3.$ver/site-packages/yt_dlp/YoutubeDL.py" ] && set pyfile "$PREFIX/lib/python3.$ver/site-packages/yt_dlp/YoutubeDL.py"
    end
    set patchfile ~/repos/dotfiles/scripts/patches/yt-dlp-YoutubeDL.py.diff
    if command -vq sudo
        patch $pyfile --input $patchfile --silent -f --reject-file - --dry-run &>/dev/null
        and sudo patch $pyfile --input $patchfile --silent -f --reject-file -
    else
        patch $pyfile --input ~/repos/dotfiles/scripts/patches/yt-dlp-YoutubeDL.py.diff --silent -f --reject-file - &>/dev/null
    end

    if [ -z "$url" ]
        # TODO: enter loop mode instead!
        printf "no url given!\n"
        return 1
    end

    if [ -d "$XDG_CONFIG_HOME/librewolf/librewolf/" ]
        set -f cookies --cookies-from-browser "firefox:$XDG_CONFIG_HOME/librewolf/librewolf/"
    end

    # strip playlist params
    set url (printf "$url" | sed -r 's/&list=.*$//')

    # pick and choose if no fmt given
    if [ -z "$fmt" ]
        mkdir -p $XDG_VIDEOS_DIR/yt/fmtcache/
        set fmtfile $XDG_VIDEOS_DIR/yt/fmtcache/(
            echo "$url" \
            | tr -dc \[:alnum:\]_- \
            | sed -E 's/^https(wwwyoutubecomwatchv|youtube)(.{11}).*/\2/')
        [ -e "$fmtfile" ] || yt-dlp $cookies --quiet --no-sponsorblock -F "$url" >$fmtfile

        # rg '^\d+-0' $fmtfile

        set -f fmt (
            cat $fmtfile \
            | fzf --tac \
            | kt 1)
        [ -z "$fmt" ] && return 2
    end

    # pick best audio for yt
    if echo $url | grep -Eq 'youtu.be|youtube.com'
        [ -e "$fmtfile" ] || return 3
        set afmt (rg 'original \(default\)' $fmtfile | tail -n1 | kt 1)
        [ -z "$afmt" ] && set afmt "bestaudio"
        set fmt "$fmt+$afmt"
    end

    yt-dlp $cookies -f "$fmt" -- "$url"

    # helper function
    # function ymux
    #     set stem (path change-extension '' $argv[1])
    #     [ -e "$stem.webm" ] || return 2
    #     if [ -e "$stem.mkv" ]
    #         set -f in mkv
    #     else if [ -e "$stem.mp4" ]
    #         set -f in mp4
    #     else
    #         return 1
    #     end
    #     ffmpeg -y -hide_banner -stats -loglevel error \
    #         -i "$stem.$in" -i "$stem.webm" \
    #         -vcodec copy -acodec copy -map 0:v -map 1:a out.$in
    #     and mv -iv out.$in "$stem.$in"
    #     rm -rfI -- "$stem.webm" "$stem.png" "$stem.webp" "$stem.jpg"
    # end
    # ymux "$(ls -1A $XDG_VIDEOS_DIR/yt/*.webm --sort time | head -n1 | path basename)"
end
