function dir2cbz -d "convert directory to .cbz archive"
    count $argv &>/dev/null || set argv */
    if not count $argv &>/dev/null
        printf "no input dirs supplied and failed to find */\n"
        return 1
    end

    for dir in $argv
        if not [ -d "$dir" ]
            echo "skipping $dir: not a directory"
            continue
        end

        set out (basename (string replace '_1.cbz' '' "$dir" )).cbz

        if [ -e "$out" ]
            [ "$(read -P "overwrite $out? [y/N] ")" = y ]
            and rm "$out" # rm cant be relied on for prompting
            or continue
        end

        set ogdir "$PWD"
        pushd "$dir/" || continue
        zip -0rq "$ogdir/$out" . || return 2
        popd
        # and rm -fr "$dir"
        printf "$out\n" # NOTE: may be used as input for other programs
    end

    while popd &>/dev/null
    end
end
