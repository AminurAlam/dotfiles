function flac_to -a ext
    set -l cover # defined later
    set -l count 0
    set -l total (count *.flac) || return
    [ -z "$ext" ] && set ext opus

    if fd -iq '(cover|folder)\.(jpg|png)'
        set cover --picture (fd -i '(cover|folder)\.(jpg|png)')[1] --discard-pictures
        echo "using `$cover[2]` as cover art"
    end

    for i in *.flac
        set -l filename (string replace ".flac" "" "$i")
        set -l count (math $count + 1)
        while [ (count (jobs | rg 'opusenc|ffmpeg|sox')) -ge 4 ]
            sleep 0.1
        end
        printf " [%02d/%d] %s\n" "$count" "$total" "$filename"

        # https://datatracker.ietf.org/doc/html/rfc7845#section-9
        if [ "$ext" = opus ] && command -vq opusenc
            opusenc --quiet --music --comp 10 --bitrate 256 $cover "$filename.flac" "$filename.opus" &
        else if command -vq ffmpeg
            ffmpeg -y -hide_banner -loglevel quiet -i "$filename.flac" -b:a 320k -r:a 44100 "$filename.$ext" &>/dev/null </dev/null &
        else if command -vq sox
            sox -q -V0 "$filename.flac" -r 44100 "$filename.$ext" &
        end
    end

    wait
end
