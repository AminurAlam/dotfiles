function ffmine -d "generate audio clips"
    [ -e "$argv[1]" ] || return 1
    [ -z "$argv[2]" ] && return 2
    [ -z "$argv[3]" ] && return 3
    date -d "$argv[2]" >/dev/null || return 2
    date -d "$argv[3]" >/dev/null || return 3

    echo "generating audio..."
    ffmpeg -y -hide_banner -loglevel error \
        -ss (string replace , . "$argv[2]") \
        -to (string replace , . "$argv[3]") \
        -i "$argv[1]" \
        -vn -acodec libvorbis $XDG_VIDEOS_DIR/audio.ogg
    and open $XDG_VIDEOS_DIR/audio.ogg
end
