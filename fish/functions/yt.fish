function yt -a link format

    if [ -z "$link" ]
        printf "no link given!\n"
        return 1
    end

    if [ -z "$format" ]
        yt-dlp -F "$link" || return
        set -f format "$(read -fP \n' > select format: ')"
        [ -z "$format" ] && return 2
        echo
    end

    command -vq ffmpeg && set -a ffmpeg --embed-metadata --embed-thumbnail --sponsorblock-mark "all"
    command -vq aria2c && set -a aria2c --downloader "dash,m3u8:aria2c"

    yt-dlp  -f "$format"  --write-subs --write-auto-subs $aria2c $ffmpeg -- "$link"
end
