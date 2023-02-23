function flac2mp3 -a bitrate
    [ -n "$bitrate" ] && set bitrate $bitrate || set bitrate 320
    for file in *.flac
        set filename (string split -n ".flac" "$file")
        echo "$filename.flac -> $filename.mp3"

        if command -sq sox
            sox -S -V0 "$filename.flac" -C $bitrate -r 44100 "$filename.mp3"
        else if command -sq ffmpeg
            ffmpeg -y -hide_banner -stats -loglevel error -i "$filename.flac" -b:a $bitrate"k" -r:a 44100 "$filename.mp3"
        end
    end
end