function flac2opus -d "convert audio from flac to opus"
    count $argv &>/dev/null || set argv *.flac
    if not count $argv &>/dev/null
        printf "no input files supplied and failed to find *.flac\n"
        return 1
    end

    if fd -iq '(cover|folder)\.(jpg|png)'
        set -f cover --picture (du -h (fd -i '(cover|folder)\.(jpg|png)') | sort -hr | fzf) --discard-pictures
        echo "using `$cover[2]` as cover art"
    end

    set total (count $argv)
    for n in (seq (count $argv))
        while [ (count (jobs | rg 'opusenc|ffmpeg|sox')) -ge 4 ]
            sleep 0.1
        end

        set file "$argv[$n]" (path change-extension opus "$argv[$n]")
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
