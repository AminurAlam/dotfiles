function music
    set files (fd -d1 '.*\.(mp3|ogg|opus|flac|lrc)' | sort -g)
    set max (printf "%s\n" $files | wc -L)
    set filecount (count $files)

    if [ "$filecount" = 0 ]
        echo no audio files
        return
    else if [ "$filecount" = 1 ] && count *.cue
        # split single discs
        set -f original (fd -d1 '.*\.(mp3|ogg|opus|flac|lrc)')
        echo $original
        deflacue -d . .
        rm -i "$original"
        return 0
    end



    for file in $files
        set new (echo $file |
            sd '^(\d+)( -|\.) ' '$1 ' |
            sd '^(\d) ' '0$1 ')
        set -f -a new_fn $new
        printf "%-"$max"s > %s\n" "$file" "$new"
    end

    if [ "$(read -P 'rename? [y/N] ')" = y ]
        for n in (seq $filecount)
            [  "$files[$n]" = "$new_fn[$n]" ] || mv "$files[$n]" "$new_fn[$n]"
        end
    end
end
