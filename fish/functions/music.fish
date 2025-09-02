function music -d "process music files with a single command"
    set files (fd -d1 '.*\.(mp3|ogg|opus|flac|m4a|lrc)' | sort -g) # list of editable files
    set filecount (count $files) # number of editable files
    set max (printf '%s\n' $files | wc -L) # find length of longest string

    if [ "$filecount" = 0 ]
        echo no audio files
        return
    else if [ "$filecount" = 1 ] && count *.cue # split single discs
        set -f original (fd -d1 '.*\.(mp3|ogg|opus|flac|lrc)')
        echo $original
        deflacue -d . .
        rm -i "$original"
        return 0
    end

    command -vq qmv
    and qmv -f do --editor 'nvim +"%s/\\v^(\\d+)( -|\\.) /\\1 /e" +"%s/\\v^(\\d) /0\\1 /e"' -- $files
    or printf "insatll `renameutils` and try again"
end
