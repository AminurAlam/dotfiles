function yt -a link format

    if [ -z "$format" ]
        yt-dlp -F "$link" || return
        set -f format (read -fP \n' > select format: ')
        [ -z "$format" ] && return
        echo
    end

    command -vq ffmpeg && set -a ffmpeg --embed-metadata --embed-subs --embed-thumbnail --sponsorblock-mark "all"
    command -vq aria2c && set -a aria2c --downloader "dash,m3u8:aria2c" 

    yt-dlp  -f "$format" $aria2c $ffmpeg -- "$link"
end
