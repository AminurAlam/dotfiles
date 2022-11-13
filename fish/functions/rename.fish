function rename
    [ -z $argv[1] ] && echo "usage: rename <find> [replace] [g]" && return
    [ -z $argv[2] ] && set argv[2] ""

    if command -sq sd; set replace sd $argv[1] $argv[2]
    else; set replace sed s/$argv[1]/$argv[2]/$argv[3]
    end

    if test -z $argv[2]
        for file in *
            echo $file | grep $argv[1]
        end
    else
        for file in *
            echo -e "$file\t->" $(echo "$file" | $replace )
        end
    end

    echo
    read choice -f -P "done copying, would you like to commit? [y/N] "

    if test $choice = "y" -o $choice = "Y"
        for file in *
            command mv "$file" $(echo "$file" | $replace )
        end
        echo "applied changes"
    else
        echo "no changes made"
    end

end
