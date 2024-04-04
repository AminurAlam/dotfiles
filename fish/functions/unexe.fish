function unexe
    set stdout
    set mb 000000
    set total (count (ls -1NA ))
    set count 0
    [ -z "$temp" ] && set exe "$HOME/.local/cache/temp/exe" || set exe "$temp/exe"
    mkdir -pv "$exe"

    for file in *
        set count (math $count + 1)
        printf "\033[A\n"
        printf '#%.0s' (seq (math -s 0 (tput cols) x $count/$total))

        if [ -f "$file" ]
        and stat -c '%A' -- "$file" | grep --quiet x
        and [ (stat -c '%s' -- "$file") -lt 20$mb ]
            mv -- "$file" "$exe/"
            chmod -x -- "$exe/$file" &>/dev/null
            mv -- "$exe/$file" ./
            set -a stdout (du -h "$file")
        end
    end

    printf "%s\n" $stdout
    ls "$exe"
end
