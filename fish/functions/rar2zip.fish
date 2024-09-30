function rar2zip

    if not command -vq unrar || not command -vq zip
        pacman -S --needed unrar zip || return 3
    end

    count $argv &>/dev/null || set argv *.rar
    if not count $argv &>/dev/null
        printf "no input files supplied and failed to find *.rar\n"
        return 1
    end


    set count 0
    set total (count $argv)
    for input in $argv
        set count (math $count + 1)

        if not [ -e "$input" ]
            printf "input file `$input` doesnt exist\n"
            continue
        end

        set medium (mktemp -dt "rar2zip.XXXXX") || return 3
        set output (string split -rm1 . (basename "$input"))[1].zip

        if [ "$input" = "$output" ]
            printf "internal error: both input and output are same\n"
            continue
        end

        if [ -e "$output" ]
            [ "$(read -P "overwrite $output? [y/N] ")" = y ]
            and rm "$output" # rm cant be relied on for prompting
            or continue
        end

        printf "[%02d/%02d] %s ... " "$count" "$total" "$input"
        unrar x -idnq "$input" "$medium/" || return 1

        set ogdir "$PWD"
        pushd "$medium/" || return 3
        zip -rmq "$ogdir/$output" . || return 2
        popd
        printf "done\n"
    end

    while popd &>/dev/null
    end
end
