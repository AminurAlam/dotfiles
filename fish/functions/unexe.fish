function unexe -d "mass chmod -x files"
    set exe (mktemp -dt "unexe.XXXXX") || return 2
    count $argv &>/dev/null || set argv (fd -H -tf)
    set total (count $argv)

    if [ "$total" -lt 1 ]
        printf 'no input files supplied and failed to find files\n'
        return 1
    else if [ "$total" -gt 20 ]
        [ "$(read -P "$total files will be processed, proceed? [y/N] ")" = y ]
        or return 2
    end

    for file in $argv
        [ -L "$file" ] && continue

        if [ (uname -o) = Android ] && stat -c '%A' -- "$file" | rg -q rwx
            du -h -- "$file"
            mkdir -p -- (dirname "$exe/$file")
            mv -- "$file" "$exe/$file" &>/dev/null
            chmod -x -- "$exe/$file" &>/dev/null
            mv -- "$exe/$file" "$file" &>/dev/null
            [ -e "$file" ] || printf '%s was not restored properly\ncheck %s\n' "$file" "$exe"
        else
            chmod -x "$file"
        end
    end
end
