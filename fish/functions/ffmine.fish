function ffmine
    [ -e "$argv[1]" ] || return 1
    [ -z "$argv[2]" ] && return 2
    [ -z "$argv[3]" ] && return 3
    date -d "$argv[2]" >/dev/null || return 2
    date -d "$argv[3]" >/dev/null || return 3

    set base (string split . $argv[1])[1]

    if [ -e "$base.ass" ]
        set -f subs "$base.ass"
    else if [ -e "$base.srt" ]
        set -f subs "$base.srt"
    else
        echo "no subs found :("
    end

    echo "generating pictures..."
    ffmpeg -y -hide_banner -loglevel fatal \
        -ss (string replace , . "$argv[2]") \
        -i "$argv[1]" \
        -copyts -vf "subtitles=$subs,fps=6" -vframes 10 \
        "../screenshot %d.png"

    echo "generating audio..."
    ffmpeg -y -hide_banner -loglevel error \
        -ss (date -ud "$argv[2] + 1 hour 1 second" '+%H:%M:%S.%03N') \
        -to (date -ud "$argv[3] + 1 hour 1 second" '+%H:%M:%S.%03N') \
        -i "$argv[1]" \
        -vn -acodec libvorbis ../audio.ogg
    and open ../audio.ogg
end
