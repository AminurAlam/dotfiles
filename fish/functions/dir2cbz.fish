function dir2cbz
    count $argv &>/dev/null || set argv */

    for dir in $argv
        if not [ -d "$dir" ]
            echo "skipping $dir: not a directory"
            continue
        end

        set out "$(basename $dir).cbz"
        printf "$out "
        [ -e "$out" ] && printf "updating... "
        zip -0q "$out" "$dir/"**
        and rm -fr "$dir"
        printf "done\n"
    end
end
