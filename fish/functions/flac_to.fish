function flac_to -a ext
    set -l count 0
    set -l total (count *.flac) || return
    [ -n "$ext" ] || set -l ext ogg

    for i in *.flac
        set -l filename (string replace ".flac" "" "$i")
        set -l count (math $count + 1)

        printf " [%d/%d] %s.flac\n" "$count" "$total" "$filename"

        if command -sq opusenc
            opusenc --quiet --music --comp 10 --bitrate 256 "$filename.flac" "$filename.opus"
        else if command -sq ffmpeg
            ffmpeg -y -hide_banner -stats -loglevel error -i "$filename.flac" \
                -b:a 320k -r:a 44100 -q:a 9 "$filename.$ext" || break
        else if command -sq sox
            sox -S -V1 "$filename.flac" -r 44100 "$filename.$ext" || break
        end

        # https://en.wikipedia.org/wiki/Vorbis
        # https://trac.ffmpeg.org/wiki/TheoraVorbisEncodingGuide
        # https://trac.ffmpeg.org/wiki/Encode/HighQualityAudio
        # https://hydrogenaud.io/index.php/board,57.0.html
        # https://wiki.hydrogenaud.io/index.php?title=Recommended_Ogg_Vorbis#Recommended_Encoder_Settings
        # http://blog.tordeu.com/?p=61
        # TODO: parallel conversion
    end
end
