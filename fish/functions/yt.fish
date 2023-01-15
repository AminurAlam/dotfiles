function yt
    yt-dlp -F $argv
    yt-dlp -f (read choice -fP ">pick one: ") $argv
end
