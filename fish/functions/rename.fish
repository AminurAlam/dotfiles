

function rename

    [ -z $argv[1] ] && echo "error: no value given" && return

    set regex "s/$argv[1]/$argv[2]/$argv[3]"

    for file in *
        echo -e "$file\t->" $(echo "$file" | sed "$regex")
    end

    read choice -f -P "done copying, would you like to commit? [y/N] "

    if test $choice = "y" -o $choice = "Y"
        for file in *
            command mv "$file" $(echo "$file" | sed "$regex")
        end
        echo "applied changes"
    else
        echo "no changes made"
    end

end
