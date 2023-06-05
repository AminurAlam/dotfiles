function rar2zip
    set -l filename (string split -n ".cbr" "$argv[1]")
    set -l stuff (unrar lb "$filename.cbr" | awk -F '/' '{print $1}' | sort | uniq)

    printf "$filename.cbr -> $filename.cbz\n"

    printf "checking dependencies\n"
    pacman -S --needed unrar zip >/dev/null

    printf "extracting $filename.cbr to $stuff\n"
    unrar x "$filename.cbr" &>/dev/null || return

    printf "compressing $stuff\n"
    printf "to $filename.cbz\n"
    zip -rmq "$filename.cbz" $stuff
end
