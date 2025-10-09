function conv -d "reencode files to save some space"
    count $argv &>/dev/null || set argv *.mp4
    if not count $argv &>/dev/null
        printf "no input files supplied and failed to find *.flac\n"
        return 1
    end

    # TODO: print saved storage
    # TODO: add image formats
    mkdir -p compressed
    for i in $argv
        [ -e "compressed/$i" ] && continue
        # mediainfo --Output="General;%Duration/String%" $i
        ffprobe -hide_banner "$i" 2>| rg --only-matching 'Duration: [0-9:.]+'
        set start (date +%s)
        if command -vq pv
            # requies mov files
            pv "$i" | ffmpeg -y -hide_banner -loglevel error -v warning -i pipe:0 -vcodec h264 -acodec copy -preset fast compressed/$i
            and rm $i
        else
            ffmpeg -y -hide_banner -stats -loglevel error -i $i -vcodec h264 -acodec copy -preset fast compressed/$i
            and rm $i
        end
        [ "$i" = "$argv[-1]" ] || sleep (math "min 40, ( ($(date +%s)-$start) / 2 )")
    end
end
