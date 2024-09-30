function unexe
    set exe (mktemp -dt "unexe.XXXXX") || return 2
    count $argv &>/dev/null || set argv (fd -H -tf -S '-20mi')
    set total (count $argv)

    if [ "$total" -lt 1 ]
        printf "no input files supplied and failed to find files less than 20mb\n"
        return 1
    else if [ "$total" -gt 20 ]
        [ "$(read -P "$total files will be processed, proceed? [y/N] ")" = y ]
        or return 2
    end

    for file in $argv
        [ -L "$file" ] && continue

        if stat -c '%A' -- "$file" | rg -q rwx
            du -h -- "$file"
            mkdir -p -- (dirname "$exe/$file")
            mv -- "$file" "$exe/$file" &>/dev/null
            chmod -x -- "$exe/$file" &>/dev/null
            # mv -- "$exe/$file" "$file"
            mv -- "$exe/$file" "$file" &>/dev/null
            [ -e "$file" ] || printf "$file was not restored properly\ncheck $exe\n"
        end
    end
end
