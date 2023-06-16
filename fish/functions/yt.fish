function yt
    yt-dlp -F "$argv" || return

    set -l format (read -fP \n' > select format: ') || return
    echo

    command -vq aria2c &&
        yt-dlp --downloader "dash,m3u8:aria2c" -f "$format" "$argv" ||
        yt-dlp -f "$format" "$argv"
end
