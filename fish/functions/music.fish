function music -d "process music files with a single command"
    set files (fd -d1 '.*\.(mp3|ogg|opus|flac|lrc)' | sort -g) # list of editable files
    set filecount (count $files) # number of editable files
    set max (printf "%s\n" $files | wc -L) # find length of longest string

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

    for file in $files
        set new (echo $file |
            sed -E 's/^([0-9]+)( -|\.) /\1 /' |
            sed -E 's/^([0-9]) /0\1 /'
        )
        set -f -a new_fn $new
        printf "%-"$max"s > %s\n" "$file" "$new"
    end

    if [ "$(read -P 'rename? [y/N] ')" = y ]
        for n in (seq $filecount)
            [ "$files[$n]" = "$new_fn[$n]" ]
            or mv "$files[$n]" "$new_fn[$n]"
        end
    end
end
