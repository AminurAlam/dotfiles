function flac_to -a ext
    set -l count 0
    set -l total (count *.flac) || return
    [ -z "$ext" ] && set ext opus

    for i in *.flac
        set -l filename (string replace ".flac" "" "$i")
        set -l count (math $count + 1)
        while [ (count (jobs)) -ge 5 ]; sleep 0.1; end
        printf " [%d/%d] %s\n" "$count" "$total" "$filename"

        if [ $ext = opus ] && command -vq opusenc
            opusenc --quiet --music --comp 10 --bitrate 256 "$filename.flac" "$filename.opus" &
        else if command -vq ffmpeg
            ffmpeg -y -hide_banner -loglevel quiet -i "$filename.flac" -b:a 320k -r:a 44100 "$filename.$ext" &>/dev/null</dev/null &
        else if command -vq sox
            sox -q -V0 "$filename.flac" -r 44100 "$filename.$ext" &
        end
    end

    wait
end
