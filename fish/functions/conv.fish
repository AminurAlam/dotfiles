function conv -d "reencode files to save some space"
    count $argv &>/dev/null || set argv *.mp4
    if not count $argv &>/dev/null
        printf "no input files supplied and failed to find *.flac\n"
        return 1
    end

    if [ (path basename $PWD) = compressed ]
        printf 'you are in `compressed` dummy\n'
        printf ' $ cd ..\n'
        cd ..
        return 1
    end

    command -vq pv || sudo pacman -S pv

    # TODO: add image formats
    mkdir -p compressed
    for i in $argv
        [ -e "compressed/$i" ] && begin
            printf "already compressed: %s\n" $i
            continue
        end

        ffprobe -hide_banner "$i" 2>| rg --only-matching 'Duration: [0-9:.]+'
        set size (du $i | kt 1)
        set start (date +%s)
        # NOTE: requies mov files
        pv -i 0.2 "$i" | ffmpeg -y -hide_banner -loglevel error -v warning -i pipe:0 -vcodec h264 -acodec copy -preset fast compressed/$i
        and rm $i
        printf "saved:%s\n" (qalc $size kB - (du compressed/$i | kt 1) kB | kt = 2)
        [ "$i" = "$argv[-1]" ] || sleep (math "min 40, ( ($(date +%s)-$start) / 2 )")
    end
end
