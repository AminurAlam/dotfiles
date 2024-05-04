function unexe -a input
    set stdout
    set mb 000000
    set total (count (ls -1NA ))
    set count 0
    set -q temp && set exe "$temp/exe" || set exe "$HOME/.local/cache/temp/exe"

    mkdir -pv "$exe"

    if [ -n "$input" ]
        mv -- "$input" "$exe/"
        chmod -x -- "$exe/$input" &>/dev/null
        mv -- "$exe/$input" ./
        return 0
    end

    for file in *
        set count (math $count + 1)
        printf "\033[A\n"
        printf '#%.0s' (seq (math -s 0 (tput cols) x $count/$total))

        if [ -f "$file" ]
        and stat -c '%A' -- "$file" | grep --quiet x
        and [ (stat -c '%s' -- "$file") -lt 20$mb ]
            mv -- "$file" "$exe/$file"
            chmod -x -- "$exe/$file" &>/dev/null
            mv -- "$exe/$file" ./
            set -a stdout (du -h "$file")
        end
    end

    printf "%s\n" $stdout
    ls "$exe"
end
