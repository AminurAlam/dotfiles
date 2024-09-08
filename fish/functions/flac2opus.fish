function flac2opus
    count $argv &>/dev/null || set argv *.flac
    set total (count $argv || return)

    if fd -iq '(cover|folder)\.(jpg|png)'
        set -f cover --picture (fd -i '(cover|folder)\.(jpg|png)' | $LAUNCHER) --discard-pictures
        echo "using `$cover[2]` as cover art"
    end

    for n in (seq (count $argv))
        while [ (count (jobs | rg 'opusenc|ffmpeg|sox')) -ge 4 ]
            sleep 0.1
        end

        set file "$argv[$n]" (string replace ".flac" ".opus" "$argv[$n]")
        printf "[%02d/%02d] %s\n" "$n" "$total" "$file[1]"

        if command -vq opusenc
            opusenc --quiet --music --comp 10 --bitrate 256 $cover "$file[1]" "$file[2]" &
        else if command -vq ffmpeg
            ffmpeg -y -hide_banner -loglevel quiet -i "$file[1]" -b:a 320k -r:a 44100 "$file[2]" &>/dev/null </dev/null &
        else if command -vq sox
            sox -q -V0 "$file[1]" -r 44100 "$file[2]" &
        else
            echo "install opusenc, ffmpeg or sox"
        end
    end

    wait
end
