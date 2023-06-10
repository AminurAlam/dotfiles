function flac_to -a ext
    set -l count 0
    set -l total (count *.flac) || exit
    [ -n "$ext" ] || set -l ext ogg

    for i in *.flac
        set -l filename (string replace ".flac" "" "$i")
        set -l count (math $count + 1)

        printf "\n [%d/%d] %s.flac -> %s.%s\n" \
            "$count" "$total" "$filename" "$filename" "$ext"

        if command -sq ffmpeg
            ffmpeg -y -hide_banner -stats -loglevel error -i "$filename.flac" \
                -b:a 320k -r:a 44100 "$filename.$ext" || break
        else if command -sq sox
            sox -S -V1 "$filename.flac" -r 44100 "$filename.$ext" || break
        end
    end
end
