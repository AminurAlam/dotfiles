function ffmine -d "generate screenshots and audio clips"
    [ -e "$argv[1]" ] || return 1
    [ -z "$argv[2]" ] && return 2
    [ -z "$argv[3]" ] && return 3
    date -d "$argv[2]" >/dev/null || return 2
    date -d "$argv[3]" >/dev/null || return 3

    set base (string split . $argv[1])[1]

    if [ -e "$base.ass" ]
        set -f subs "$base.ass"
    else if [ -e "$base.ja.ass" ]
        set -f subs "$base.ja.ass"
    else if [ -e "$base.srt" ]
        set -f subs "$base.srt"
    else
        echo "no subs found :("
    end

    fd -d1 '^anime_\d0?_[0-9a-f]{32}\.jpg$' "$XDG_VIDEOS_DIR/" -x rm
    echo "generating pictures..."
    ffmpeg -y -hide_banner -loglevel fatal \
        -ss (string replace , . "$argv[2]") \
        -i "$argv[1]" \
        -copyts -vf "subtitles=$subs,fps=6" -vframes 10 \
        "$XDG_VIDEOS_DIR/anime_%d_$(random | md5sum | cut -d\  -f1).jpg"

    echo "generating audio..."
    ffmpeg -y -hide_banner -loglevel error \
        -ss (string replace , . "$argv[2]") \
        -to (string replace , . "$argv[3]") \
        -i "$argv[1]" \
        -vn -acodec libvorbis $XDG_VIDEOS_DIR/audio.ogg
    and open $XDG_VIDEOS_DIR/audio.ogg
end
