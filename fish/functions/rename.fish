function rename
    [ -z $argv[1] ] && echo "usage: rename <find> [replace] [g]" && return

    command -sq sd || return

    for file in *
        echo "$file -> " (echo "$file" | sd $argv )
    end

    echo
    read choice -f -P "make changes? [y/N] "

    if test $choice = "y" -o $choice = "Y"
        for file in *
            command mv "$file" "$(echo "$file" | sd $argv )"
        end
        echo "applied changes"
    else
        echo "no changes made"
    end
end
